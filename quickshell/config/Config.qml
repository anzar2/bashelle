pragma ComponentBehavior: Bound
pragma Singleton
import Quickshell.Io
import QtQuick
import Quickshell
import qs.utils
import qs.services

FileView {
  id: root
  property bool ready: false
  property alias panel: jsonAdapter.panel
  property alias frames: jsonAdapter.frames
  property alias clock: jsonAdapter.clock
  property alias workspaces: jsonAdapter.workspaces
  property alias notifications: jsonAdapter.notifications
  property alias systemTray: jsonAdapter.systemTray
  property alias wallpapers: jsonAdapter.wallpapers
  property alias pipewire: jsonAdapter.pipewire
  property alias bluetooth: jsonAdapter.bluetooth
  property alias network: jsonAdapter.network
  property alias upower: jsonAdapter.upower
  property alias appearance: jsonAdapter.appearance
  
  path: `${Xdg.paths.home}/.config/quickshell/shell.json`
  watchChanges: true
  onFileChanged: {
    reload()
    Logger.p("Config", `File ${path} has been modified`)
  }
  onLoaded: ready = true

  onLoadFailed: {
    writeAdapter()
    reload()
  }
  onAdapterUpdated: writeAdapter()

  Component.onCompleted: Logger.p("Config", "Service started")

  JsonAdapter {
    id: jsonAdapter
    
    property AppearanceConfig appearance: AppearanceConfig {}
    
    property FramesConfig frames: FramesConfig {}
    property PanelConfig panel: PanelConfig {}
    property ClockConfig clock: ClockConfig {}
    property SystemTrayConfig systemTray: SystemTrayConfig {}
    property WorkspacesConfig workspaces: WorkspacesConfig {}
    property NotificationConfig notifications: NotificationConfig {}
    property WallpaperConfig wallpapers: WallpaperConfig {}
    property PipewireConfig pipewire: PipewireConfig {}
    property DeviceConfig bluetooth: DeviceConfig {}
    property DeviceConfig network: DeviceConfig {}
    property UPowerConfig upower: UPowerConfig {}
  }
}
