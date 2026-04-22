import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services
import qs.components
import qs.utils

PanelWindow {
  id: desktop
  WlrLayershell.layer: WlrLayer.Background
  color: Qt.alpha("black", 0.0)
  focusable: true

  property list<MenuEntry> menuList: [
    MenuEntry {
      text: "Reload"
      nerdIcon: NerdIcons.reload
      onTriggered: {
        Quickshell.execDetached(["hyprctl", "reload"])
        Quickshell.reload(false)
      }
    },
    MenuEntry {
      text: "Wallpapers"
      nerdIcon: NerdIcons.wallpaper
      onTriggered: Widgets.wallpaperSelector.show()
    },
  ]

  PopupMenu {
    id: menu
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
      menu.show(desktop, "window", desktop.menuList, event.position.x, event.position.y)
    }
  }
}