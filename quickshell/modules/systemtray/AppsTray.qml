pragma ComponentBehavior: Bound
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import qs.config
import qs.components
import Quickshell

Item {
  id: root
  property alias icons: _iconsFlow
  property list<SystemTrayItem> appItems: []

  implicitWidth: Config.panel.isVertical() ? parent.width : (icons.width + icons.spacing * 4)
  implicitHeight: Config.panel.isVertical() ? (icons.height + icons.spacing * 4):  parent.height
  visible: appItems.length > 0

  AppTrayMenu {
    id: menu
  }

  Flow {
    id: _iconsFlow
    flow: Config.panel.getFlow()
    anchors.centerIn: parent
    spacing: 4


    Repeater {
      model: root.appItems
      delegate: IconImage {
        id: icon
        required property SystemTrayItem modelData
        source: modelData.icon
        implicitSize: 15
        HoverHandler { id: hoverHandler; cursorShape: Qt.PointingHandCursor }

        QsMenuOpener {
          id: menuOpener
          menu: icon.modelData.menu
        }

        TapHandler {
          onSingleTapped: {
            let y = Config.panel.isVertical() ? 0 : root.height + 6
            menu.show(root, "item", menuOpener, root.width + 6, y)
          }
        }
      }
    }
  }
}
