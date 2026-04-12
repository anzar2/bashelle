import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.config
import qs.theme
import Quickshell.Services.Mpris
import qs.components
import qs.services
import "barmodules"

SPanelWindow {
  id: bar
  property int moduleSpacing: 4
  implicitWidth: Config.panel.size
  exclusiveZone: implicitWidth - Config.frames.width
  color: "transparent"

  WlrLayershell.namespace: "panel"
  WlrLayershell.layer: Hyprland.focusedMonitor.activeWorkspace.hasFullscreen ? WlrLayer.Top : WlrLayer.Overlay
  WlrLayershell.exclusionMode: WlrLayershell.Normal

  SRectangle {
    id: bg
    property real contentWidth: width - (padding * 2)
    anchors.fill: parent
    
    padding: 8
    radius: 0
     
    Column {
      anchors.top: parent.top
      width: bg.contentWidth
      
      Workspaces {
        implicitWidth: parent.width
        monitor: bar.screen
      }
    }

    Column {
      anchors.bottom: parent.bottom
      width: bg.contentWidth
      spacing: 4
      
      SystemTray { 
        implicitWidth: parent.width 
      }
      Clock {  implicitWidth: parent.width  }
      HubLauncher { implicitWidth: parent.width }
    }
  }
}

