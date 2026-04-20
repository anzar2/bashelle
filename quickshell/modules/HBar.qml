pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.config
import QtQuick.Layouts
import QtQuick.Controls
import qs.components
import qs.modules.systemtray
import qs.modules.workspaces

SPanelWindow {
  id: bar
  property int moduleSpacing: 6
  implicitHeight: Config.panel.size
  exclusiveZone: implicitHeight - Config.frames.width
  WlrLayershell.namespace: "panel"
  WlrLayershell.layer: WlrLayer.Bottom
  WlrLayershell.exclusionMode: WlrLayershell.Normal
  color: "transparent"
  visible: true

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


      Clock {
        implicitHeight: parent.height
      }

      SystemTray {
        implicitHeight: parent.height
      }


      HubLauncher {
        implicitHeight: parent.height
        implicitWidth: 20
      }
    }
  }
}

