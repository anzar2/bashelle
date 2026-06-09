import QtQuick.Controls
import QtQuick

import qs.Theme
import qs.Components

TabBar {
  id: tab
  property real indicatorHeight: 2
  property color backgroundColor: "transparent"
  property bool showBorder: false
  padding: 4

  background: SRectangle {
    color: tab.backgroundColor
    showBorder: tab.showBorder
    clip: true

    SRectangle {
      implicitWidth: parent.width
      implicitHeight: tab.indicatorHeight
      y: tab.height - implicitHeight
      color: Theme.colors.surface_container
    }
    
    SRectangle {
      id: _indicator
      implicitHeight: tab.indicatorHeight
      implicitWidth: tab.currentItem.width + (tab.padding * 2)
      x: tab.currentItem.x
      y: tab.height - implicitHeight
      color: Theme.colors.primary
      
      Behavior on x { 
        NumberAnimation {
          duration: 500
          easing.type: Easing.OutBack
        } 
      }
    }
  }
}
