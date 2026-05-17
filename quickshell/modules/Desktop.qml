import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.components
import qs.utils
import qs.config
import qs.services
import QtQuick.Controls

PanelWindow {
  id: desktop
  WlrLayershell.layer: WlrLayer.Background
  color: Qt.alpha("black", 0.0)
  focusable: true

  anchors {
    top: true
    bottom: true
    right: true
    left: true
  }

  Item {
    anchors.fill: parent
    
    ContextMenu.menu: SMenu {
      id: menu
      implicitWidth: 150

      SMenuItem {
        nerdIcon.text: NerdIcons.reload
        text: "Reload"
        onClicked: Quickshell.reload(false)
      }

      SMenuItem {
        text: "Open Terminal"
        nerdIcon.text: NerdIcons.terminal
        onClicked: Xdg.openTerminal()
      }

      SMenuItem {
        nerdIcon.text: NerdIcons.folder
        text: "File Manager"
        onClicked: Xdg.open()
      }
      
      SMenuSeparator {}

      SMenuItem {
        nerdIcon.text: NerdIcons.wallpaper
        text: "Wallpapers"
        onClicked: Widgets.wallpaperSelector.show()
      }

      SMenu {
        title: "Panel"
        icon.name: NerdIcons.layout
        implicitWidth: parent.width

        Repeater {
          model: [
            { pos: "top",    icon: NerdIcons.border_top    },
            { pos: "left",   icon: NerdIcons.border_left   }, 
            { pos: "right",  icon: NerdIcons.border_right  }, 
            { pos: "bottom", icon: NerdIcons.border_bottom }, 
          ]
          delegate: SMenuItem {
            required property var modelData
            text: `Move ${modelData.pos}`
            nerdIcon.text: modelData.icon
            textItem.font.capitalization: Font.Capitalize
            onClicked: Config.panel.setPosition(modelData.pos)
          }
        }
      }
    }
  }
}
