import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.config
import qs.components
import qs.modules.panel.systemtray
import qs.services
import qs.modules.panel.workspaces
import qs.utils

SPanelWindow {
  id: bar
  property int moduleSpacing: 4
  implicitWidth: Config.panel.size
  exclusiveZone: implicitWidth
  color: "transparent"

  WlrLayershell.namespace: "panel"
  WlrLayershell.layer: WlrLayer.Top
  
  SRectangle {
    id: bg
    property real contentWidth: width - (padding * 2)
    anchors.fill: parent
    padding: 8
    radius: 0
     
    Column {
      anchors.top: parent.top
      width: bg.contentWidth


      SButton {
        nerdIcon: NerdIcon { text: NerdIcons.apps }
        onClicked: Widgets.settings.toggle()
      }
      
      Workspaces {
        implicitWidth: parent.width
        monitor: bar.screen
      }
    }

    Column {
      anchors.bottom: parent.bottom
      width: bg.contentWidth
      spacing: 4
      
      
      AppsTray { implicitWidth: parent.width }
      StatusTray { implicitWidth: parent.width }
      Clock {  implicitWidth: parent.width  }
      HubLauncher { implicitWidth: parent.width }
    }
  }
}

