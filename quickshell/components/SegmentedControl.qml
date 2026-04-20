import QtQuick.Controls
import QtQuick
import qs.theme

TabBar {
  id: tab
  property color backgroundColor: Theme.colors.surface_container
  property bool showBorder: false

  background: SRectangle {
    color: tab.backgroundColor
    showBorder: tab.showBorder
    SRectangle {
      id: _indicator
      implicitHeight: tab.currentItem.height
      implicitWidth: tab.currentItem.width
      x: tab.currentItem.x
      color: Theme.colors.primary
      
      Behavior on x { 
        NumberAnimation {
          duration: 250
          easing.type: Easing.OutQuart
        } 
      }
    }
  }
}
