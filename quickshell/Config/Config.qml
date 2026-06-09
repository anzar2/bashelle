pragma Singleton
import Quickshell.Io
import QtQuick
import qs.Services
import qs.Services.Xdg

Service {
  id: service
  name: "Config"
  property alias file: config
  property alias panel:         jsonAdapter.panel
  property alias workspaces:    jsonAdapter.workspaces
  property alias systemTray:    jsonAdapter.systemTray
  property alias wallpapers:    jsonAdapter.wallpapers
  property alias upower:        jsonAdapter.upower
  property alias appearance:    jsonAdapter.appearance
  property alias clock:         jsonAdapter.clock
  property alias notifications: jsonAdapter.notifications

  FileView {
    id: config
    path: `${Xdg.paths.home}/.config/quickshell/shell.json`
    watchChanges: true
    onFileChanged: reload()
    onLoaded: service.ready = true

    onLoadFailed: error => {
      if (error === FileViewError.FileNotFound) {
        writeAdapter()
        reload()
      }
    }
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: jsonAdapter
      
      property AppearanceConfig appearance: AppearanceConfig {}
      property PanelConfig panel: PanelConfig {}
      property SystemTrayConfig systemTray: SystemTrayConfig {}
      property WorkspacesConfig workspaces: WorkspacesConfig {}
      property WallpaperConfig wallpapers: WallpaperConfig {}
      property UPowerConfig upower: UPowerConfig {}
      property ClockConfig clock: ClockConfig {}
      property NotificationConfig notifications: NotificationConfig {}
    }
  }
}

