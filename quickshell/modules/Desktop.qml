import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services

PanelWindow {
  id: desktop
  WlrLayershell.layer: WlrLayer.Background
  color: "transparent"
  focusable: true

  ListModel {
    id: contextMenu
    
    ListElement {
      nerdIcon: "󰑓"
      text: "Reload"
      triggered: () => {
        Quickshell.execDetached(["hyprctl", "reload"])
        Quickshell.reload(false)
      }
    }

    ListElement {
      text: "Wallpapers"
      nerdIcon: "󰸉"
      triggered: () => {
        Widgets.wallpaperSelector.show()
      }
    }

    ListElement {
      text: "Xao"
    }
  }

  anchors {
    top: true
    bottom: true
    right: true
    left: true
  }


  TapHandler {
    acceptedButtons: Qt.RightButton
    
    onTapped: (event) => {
      Overlay.showContextMenu(contextMenu, event.position.x, event.position.y)
    }
  }
}