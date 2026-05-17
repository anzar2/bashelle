pragma ComponentBehavior: Bound
import QtQuick.Controls
import QtQuick
import qs.utils
import Quickshell

Menu {
  id: root
  padding: 4
  cascade: true
  implicitWidth: 150
  signal clicked()
  
  background: SRectangle {
    showBorder: true
    shadowEnabled: true
  }

  delegate: SMenuItem {
    id: menuItem
    nerdIcon.text: icon.name
    icon: icon
    onClicked: root.clicked()
    arrow: NerdIcon {
      anchors.right: parent.right
      anchors.top: parent.top
      anchors.margins: 8
      size: 9
      text: NerdIcons.chevron_right
      color: menuItem.foregroundColor
    }
  }

  enter: Transition {
    NumberAnimation {
      property: "scale"
      from: 0.97
      to: 1
      duration: 100
    }
  }

  exit: Transition {
    NumberAnimation {
      property: "scale"
      to: 0.97
      duration: 100
    }
  }
}
