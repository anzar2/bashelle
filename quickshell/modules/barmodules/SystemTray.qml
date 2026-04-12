import QtQuick
import qs.components
import Quickshell.Services.SystemTray
import qs.config
import qs.theme

SRectangle {
  id: root
  implicitHeight: flow.height
  implicitWidth: flow.width
  showBorder: true
  color: "transparent"
  
  Flow {
    id: flow
    flow: Config.panel.getFlow()

    AppsTray {
      appItems: SystemTray.items.values
      
    }

    StatusIndicator {
      implicitHeight: Config.panel.isVertical() ? iconsFlow.height : root.height
      implicitWidth: Config.panel.isVertical() ? root.width : iconsFlow.width
    }
  }
}
