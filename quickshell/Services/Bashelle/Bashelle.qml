pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Io

import qs.Config
import qs.Services
import qs.Services.Awww
import qs.Services.Matugen
import qs.Services.Notifications
import qs.Services.Pipewire
import qs.Services.UPower
import qs.Services.Hyprland
import qs.Services.Xdg

Service {
  id: service
  name: "Bashelle"
  
  readonly property bool debug: true
  // wich services and singletons loads just on start
  readonly property var bootstrapServices: [
    Awww, 
    Matugen,
    Notifications,
    UPower, 
    Pw, 
    Hypr, 
  ]

  onStart: Config.start()

  function reload(force: bool) {
    Quickshell.reload(force)

    if (Xdg.currentDesktop === "Hyprland") {
      Quickshell.execDetached("hyprctl reload")
    }
  }
  
  property var overlay: PersistentProperties {
    property real opacity: 0.4
    property bool active: false

    function toggle() { active = !active }
  }

  property var panel: PersistentProperties {
    property bool statusTrayCollapsed: false
  }

  Connections {
    target: Quickshell

    function onReloadCompleted() {
      if (!service.debug) {
        Quickshell.inhibitReloadPopup()
      }
    }
  }

  Connections { 
    target: Config

    function onReadyChanged() {
      if (Config.ready) {
        for (let s of service.bootstrapServices) {
          s.start()
        }
        service.ready = true
      }
    }
  }

  // ipc calls
  IpcHandler {
    target: "bashelle"
    enabled: service.ready

    function reload() {
      service.reload()
    }

    function forceReload() {
      service.reload(true)
    }
  }

  IpcHandler {
    target: "panel"
    enabled: Config.ready

    function move(position: string): string {
      if (Config.panel.position !== position) {
        Config.panel.setPosition(position)
        return "panel moved to " + position
      }
      return "is already on " + position 
    }
  }
  
  IpcHandler {
    target: "config"
    enabled: Config.ready

    function writeAdapter() { 
      Config.file.writeAdapter() 
      Config.file.reload()
    }
  }
}
