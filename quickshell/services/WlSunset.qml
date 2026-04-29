pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import qs.services

Singleton {
  id: root
  readonly property bool enabled: config.enabled

  enum Mode { Manual, Scheduled, Always }

  property alias config: _config
  property alias process: daemon
  property bool ready: false
  property string sunrise
  property string sunset

  property var cmd: {
    switch(config.mode) {
      case WlSunset.Mode.Manual:
        return [
        "wlsunset",
        "-t", config.temp,
        "-S", config.sunrise,
        "-s", config.sunset
      ]
      case WlSunset.Mode.Scheduled:
        return [
          "wlsunset",
          "-t", config.temp,
          "-L", config.long,
          "-l", config.lat
        ]
      case WlSunset.Mode.Always:
        return ["wlsunset", "-t", config.temp, "-T", config.temp + 1]
      default:
        return []
    }
  }

  FileView {
    id: _config
    path: `${Xdg.paths.state}/bashelle/wlsunset.json`
    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()
    onLoaded:  {
      root.ready = true
      Logger.p("WlSunset", "Service started")
    }

    property alias enabled: _adapter.enabled
    property alias temp: _adapter.temp
    property alias lat: _adapter.lat
    property alias long: _adapter.long
    property alias sunset: _adapter.sunset
    property alias sunrise: _adapter.sunrise
    property alias mode: _adapter.mode

    JsonAdapter {
      id: _adapter
      property real temp: 3200
      property real lat: 0
      property real long: 0
      property string sunrise: "6:30"
      property string sunset: "18:00"
      property bool enabled: false
      property int mode: 0 // manual | scheduled | always
    }
  }

  function toggle() {
    config.enabled = !config.enabled
    Logger.p("WlSunset", config.enabled ? "enabled" : "disabled")
  }

  onReadyChanged: {
    if (ready && enabled) {
      daemon.running = true
    }
  }

  onEnabledChanged: {
    if (ready && enabled && !daemon.running) {
      daemon.running = true
    }

    if (ready && !enabled && daemon.running) {
      daemon.running = false
    }
  }

  Process {
    id: daemon
    command: root.cmd
    onCommandChanged: {
      if (running) { running = false }
      if (root.enabled) { running = true }
    }

    stderr: SplitParser {
      splitMarker: ""
      onRead: (line) => { 
        const match = line.match(/sunrise (\d{2}:\d{2}), sunset (\d{2}:\d{2})/)
        if (match) {
          root.sunrise = match[1]
          root.sunset = match[2]
        }
        Logger.p("WlSunset", line) 
      }
    }
  }
}