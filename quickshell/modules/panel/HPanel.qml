pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.config
import QtQuick.Layouts
import qs.components
import qs.utils
import qs.modules.panel.systemtray
import qs.modules.panel.workspaces
import qs.services
import qs.theme

SPanelWindow {
  id: bar
  property int moduleSpacing: 6
  implicitHeight: Config.panel.size
  exclusiveZone: implicitHeight - Config.frames.width
  WlrLayershell.namespace: "widget"
  WlrLayershell.layer: WlrLayer.Top
  color: "transparent"
    
  SRectangle {
    id: bg
    property real contentHeight: height - (padding * 2)
    anchors.fill: parent
    shadowEnabled: true
    padding: 8
    radius: 0
    
    Row {
      spacing: 8
      anchors.left: parent.left
      anchors.leftMargin: 8
      height: bg.contentHeight

      SButton {
        nerdIcon: NerdIcon { text: NerdIcons.apps }
        onClicked: Widgets.settings.toggle()
      }

      Workspaces {
        implicitHeight: parent.height
        monitor: bar.screen
      }
    }

    Row {
      anchors.centerIn: parent
      height: bg.contentHeight
    }

    RowLayout {
      anchors.right: parent.right
      anchors.rightMargin: 8
      height: bg.contentHeight
      spacing: 4

      

      AppsTray { implicitHeight: parent.height }
      StatusTray {  implicitHeight: parent.height }


      Clock {
        implicitHeight: parent.height
        implicitWidth: textItem.implicitWidth + padding * 2
      }

      HubLauncher {
        implicitHeight: parent.height
        implicitWidth: 25
      }
    }
  }
}

