import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.components
import QtQuick.Layouts
import qs.services

PanelWindow {
  id: desktop
  WlrLayershell.layer: WlrLayer.Background
  color: "transparent"
  focusable: true

  anchors {
    top: true
    bottom: true
    right: true
    left: true
  }

  PopupMenu {
    id: menu
    implicitWidth: 200
    

    SButton {
      Layout.fillWidth: true
      text: "Wallpapers"
      focus: true
      nerdIcon.text: "󰸉"
      onClicked: {
        Widgets.wallpaperSelector.show()
      }
    }
  }

  TapHandler {
    acceptedButtons: Qt.RightButton
    
    onTapped: (event) => {
      if (!menu.visible) { 
        menu.toggle()
        menu.x = event.position.x
        menu.y = event.position.y
      }
    }
  }
}