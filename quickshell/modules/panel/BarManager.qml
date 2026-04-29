pragma ComponentBehavior: Bound
import qs.config
import qs.modules.panel
import QtQuick
import Quickshell

Variants {
  model: Quickshell.screens

  Item {
    id: manager
    required property ShellScreen modelData
    
    Loader {
      id: hpanel
      sourceComponent: HPanel {
        anchors.top: Config.panel.isTop()
        anchors.bottom: Config.panel.isBottom()
        anchors.right: true
        anchors.left: true
        screen: manager.modelData
      }
      active: !Config.panel.isVertical() && Config.ready
    }

    Loader {
      id: vpanel
      sourceComponent: VPanel {
        anchors.bottom: true
        anchors.top: true
        anchors.right: Config.panel.isRight()
        anchors.left: Config.panel.isLeft()
        screen: manager.modelData
      }
      active: Config.panel.isVertical() && Config.ready
    }
  }
}
