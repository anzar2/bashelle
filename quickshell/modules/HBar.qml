pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.config
import qs.components
import qs.services
import QtQuick.Layouts
import QtQuick.Controls
import "barmodules"

SPanelWindow {
  id: bar
  property int moduleSpacing: 6
  focusable: true
  implicitHeight: Config.panel.size
  exclusiveZone: implicitHeight - Config.frames.width
  WlrLayershell.namespace: "panel"
  WlrLayershell.layer: Hyprland.focusedMonitor?.activeWorkspace?.hasFullscreen ? WlrLayer.Top : WlrLayer.Overlay
  WlrLayershell.exclusionMode: WlrLayershell.Normal
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

      Workspaces {
        implicitHeight: parent.height
        monitor: bar.screen
      }
    }

    Row {
      anchors.centerIn: parent
      height: bg.contentHeight

      SButton {
        text: "Abrir wallpaper"
        onClicked: Widgets.wallpaperSelector.toggle()
      }
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

