import Quickshell.Widgets
import QtQuick
import Quickshell.Hyprland
import qs.components

SRectangle {
  id: root
  property alias icon: _icon
  property string mimeData: ""
  signal middleClicked()
  color: "transparent"
  shadowEnabled: false
  
 
  IconImage {
    anchors.centerIn: parent
    id: _icon
    
    scale: hoverHandler.hovered ? 1.05 : 1

    TapHandler {
      acceptedButtons: Qt.MiddleButton
      onTapped: root.middleClicked() 
    }
   
    HoverHandler {
      id: hoverHandler
    }
  }
  Component.onCompleted: Hyprland.refreshToplevels()
}
