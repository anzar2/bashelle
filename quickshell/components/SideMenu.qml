pragma ComponentBehavior: Bound
import QtQuick
import qs.components
import qs.theme

ListView {
  id: menu
  interactive: false
  focus: true
  spacing: 4
  
  Keys.onUpPressed: currentIndex = Math.max(0, currentIndex-1)
  Keys.onDownPressed: currentIndex = Math.min(menu.count - 1, currentIndex+1)
  
  delegate: SButton {
    id: menuItem
    required property var modelData
    required property int index
    text: modelData.text
    nerdIcon: NerdIcon {
      text: menuItem.modelData.icon
      color: menuItem.textColor
    }
    style: highlighted ? Styles.button.none : Styles.button.clear
    textColor: highlighted ? Theme.colors.on_primary : Theme.colors.on_surface
    highlighted: index == menu.currentIndex
    onClicked: menu.currentIndex = index
    width: ListView.view.width
  }
  
  SRectangle {
    id: indicator
    color: Theme.colors.primary
    width: parent.width
    implicitHeight: menu.currentItem?.height ?? 0
    y: menu.currentItem?.y ?? 0
    z: -1
    visible: menu.currentItem

    Behavior on y {
      NumberAnimation {
        duration: 500
        easing.type: Easing.OutBack
      }
    }
  }
}
