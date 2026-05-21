pragma ComponentBehavior: Bound
pragma Singleton
import Quickshell.Io
import QtQuick
import Quickshell
import qs.utils
import qs.services

Service {
  id: service
  name: "Config"
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

  FileView {
    id: config
    path: `${Xdg.paths.home}/.config/quickshell/shell.json`
    watchChanges: true
    onFileChanged: reload()
    onLoaded: service.ready = true

    onLoadFailed: {
      writeAdapter()
      reload()
    }
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: jsonAdapter
      
      property AppearanceConfig appearance: AppearanceConfig {
        onThemeChanged: {
          if (Config.ready && Awww.ready && Matugen.ready) {
            Matugen.color("#E84B7A", theme)
            Config.log("theme changed:", theme)
          }
        }
      }
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
}

