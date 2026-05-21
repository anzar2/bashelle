pragma ComponentBehavior: Bound
import qs.components
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.theme
import Quickshell.Hyprland
import qs.utils
import QtQuick.Controls
import Quickshell.Widgets

Item {
  id: workspace
  property alias grid: _grid
  property bool focused: false
  property bool hovered: hoverhandler.hovered
  property bool isSpecial: false
  property bool isEmpty: toplevels.values.length == 0
  property var toplevels
  width:  grid.width
  height: grid.height   
  signal clicked()


  Rectangle {
    id: bg
    radius: Config.appearance.radius
    anchors.fill: parent
    scale: workspace.hovered || workspace.isSpecial || workspace.toplevels.values.length > 0 ? 1 : 0
    color: workspace.focused ? "transparent" : Theme.colors.surface_container_highest

    Behavior on scale {
      NumberAnimation {
        duration: 150
      }
    }
  }


  Rectangle {
    id: dot
    radius: Config.appearance.radius
    implicitWidth: parent.width / 6
    implicitHeight: parent.height / 6
    anchors.centerIn: bg
    color: workspace.focused ? Theme.colors.on_primary : Qt.alpha(Theme.colors.primary, 0.5)
    visible: workspace.toplevels.values.length == 0
  }

  GridLayout {
    id: _grid
    flow: Config.panel.getFlow()
    rowSpacing: Config.workspaces.iconSpacing
    columnSpacing: Config.workspaces.iconSpacing
    anchors.centerIn: parent
    
    Repeater {
      model: workspace.toplevels
      delegate: IconImage {
        required property HyprlandToplevel modelData
        implicitSize: Config.workspaces.iconSize
        source: IconsMap.get(modelData?.lastIpcObject.initialClass ?? "")         
        Layout.margins: 0
        Layout.alignment: Qt.AlignCenter
        Component.onCompleted: Hyprland.refreshToplevels()
      }
    }
  }

  HoverHandler { id: hoverhandler; enabled: !workspace.focused }
  TapHandler   { id: tapHandler;   onTapped: workspace.clicked() }
}
