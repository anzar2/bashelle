pragma Singleton
import Quickshell.Io
import QtQuick
import Quickshell
import Quickshell.Hyprland

FileView {
  id: root
  property alias theme: jsonAdapter.theme
  property alias fontFamily: jsonAdapter.fontFamily
  property alias fontScale: jsonAdapter.fontScale
  property alias panel: jsonAdapter.panel
  property alias frames: jsonAdapter.frames
  property alias clock: jsonAdapter.clock
  property alias workspaces: jsonAdapter.workspaces
  property alias notifications: jsonAdapter.notifications
  property alias systemTray: jsonAdapter.systemTray

  path: `${Quickshell.env("HOME")}/.config/quickshell/shell.json`
  watchChanges: true
  onFileChanged: reload()
  onAdapterUpdated: writeAdapter()

  JsonAdapter {
    id: jsonAdapter
    property string _currentTheme: "unset"
    property string theme: "unset" // dark | light
    property string color: "auto" // <hex_color> | auto
    property string fontFamily: "Arial"
    property real fontScale: 1

    onThemeChanged: {
      if (theme === "unset") return;

      if (_currentTheme === "unset") {
        _currentTheme = theme
        return
      }

      _currentTheme = theme
      Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/scripts/change_theme.sh " + theme])
    }

    property FramesConfig frames: FramesConfig {}
    property PanelConfig panel: PanelConfig {}
    property ClockConfig clock: ClockConfig {}
    property SystemTrayConfig systemTray: SystemTrayConfig {}
    property WorkspacesConfig workspaces: WorkspacesConfig {}
    property NotificationConfig notifications: NotificationConfig {}
   
    property JsonObject osd: JsonObject {
      property JsonObject position: JsonObject {
        property bool top: false
        property bool bottom: false
        property bool right: false
        property bool left: false
      }
      property int displayTime: 2000
    }
  }
}
