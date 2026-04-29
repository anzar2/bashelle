import QtQuick
import qs.components
import Quickshell.Services.SystemTray
import qs.config
import qs.theme
import qs.services

SRectangle {
  id: root
  property alias tray: _appsTray
  property string _currentTheme: "unset"
  implicitHeight: flow.height
  implicitWidth: flow.width
  showBorder: true
  color: "transparent"

  Flow {
    id: flow
    flow: Config.panel.getFlow()

    AppsTray {
      id: _appsTray
      appItems: SystemTray.items.values
    }

    StatusIndicator {
      implicitHeight: Config.panel.isVertical() ? iconsFlow.height : root.height
      implicitWidth: Config.panel.isVertical() ? root.width : iconsFlow.width
      onClicked: Widgets.controlCenter.toggle()
    }
  }
}
