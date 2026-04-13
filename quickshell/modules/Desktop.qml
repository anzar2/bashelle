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

  anchors {
    top: true
    bottom: true
    right: true
    left: true
  }

  PopupMenu {
    id: menu
    anchor.window: desktop
    implicitWidth: 200

    SButton {
      Layout.fillWidth: true
      text: "Imagen de fondo"
      nerdIcon.text: "󰸉"
      onClicked: {
        Widgets.wallpaperSelector.show()
        menu.hide()
      }
    }
  }

  TapHandler {
    acceptedButtons: Qt.RightButton
    
    onTapped: (event) => {
      menu.visible = !menu.visible
      menu.anchor.rect.x = event.position.x
      menu.anchor.rect.y = event.position.y
    }
  }
}