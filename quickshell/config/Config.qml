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
  property alias theme: jsonAdapter.theme
  property alias fontFamily: jsonAdapter.fontFamily
  property alias fontScale: jsonAdapter.fontScale
  property alias panel: jsonAdapter.panel
  property alias frames: jsonAdapter.frames
  property alias clock: jsonAdapter.clock
  property alias workspaces: jsonAdapter.workspaces
  property alias notifications: jsonAdapter.notifications
  property alias systemTray: jsonAdapter.systemTray
  property alias wallpapers: jsonAdapter.wallpapers

  path: `${Xdg.paths.home}/.config/quickshell/shell.json`
  watchChanges: true
  onFileChanged: {
    reload()
    Logger.p("Config", `File ${path} has been modified`)
  }
  onLoaded: ready = true

  onAdapterUpdated: writeAdapter()

  Component.onCompleted: Logger.p("Config", "Service started")

  JsonAdapter {
    id: jsonAdapter
    property string theme // dark | light
    property string color: "auto" // <hex_color> | auto
    property string fontFamily: "Arial"
    property real fontScale: 1

    onThemeChanged: {
      if (root.ready) {
        Scripts.setTheme(theme)
      }
    }

    property FramesConfig frames: FramesConfig {}
    property PanelConfig panel: PanelConfig {}
    property ClockConfig clock: ClockConfig {}
    property SystemTrayConfig systemTray: SystemTrayConfig {}
    property WorkspacesConfig workspaces: WorkspacesConfig {}
    property NotificationConfig notifications: NotificationConfig {}
    property WallpaperConfig wallpapers: WallpaperConfig {}
  }
}
