import QtQuick.Controls
import QtQuick

import qs.Theme

TabBar {
  id: tab
  property var style: Styles.button.filled
  property color backgroundColor: Theme.colors.surface_container
  property bool showBorder: false
  currentIndex: 0
  
  background: Rectangle {
    color: tab.backgroundColor
    
   Rectangle {
      id: _indicator
      implicitHeight: tab.currentItem.height
      implicitWidth: tab.currentItem.width
      x: tab.currentItem.x
      color: tab.style.background
      
      Behavior on x { 
        NumberAnimation {
          duration: 250
          easing.type: Easing.OutQuart
        } 
      }
    }
  }
}
