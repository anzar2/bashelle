pragma ComponentBehavior: Bound
import QtQuick.Controls
import QtQuick
import qs.theme

Slider {
  id: slider
  property alias backgroundRect: bg
  property alias fillRect: fill

  from: 0
  to: 1
  padding: 0
  implicitWidth: slider.vertical ? 8 : 150
  implicitHeight: slider.vertical ? 150 : 8

  handle: Item {}

  background: Item {
    width: slider.width
    height: slider.height

   SRectangle {
      id: bg
      implicitWidth: parent.width
      implicitHeight: parent.height
      color: Theme.colors.surface_container_high
      showBorder: false
    }

    SRectangle {
      id: fill
      anchors.bottom: parent.bottom
      width: slider.vertical ? parent.width : slider.visualPosition * parent.width
      height: slider.vertical ? (1 - slider.visualPosition) * parent.height : parent.height
      color: sliderHover.hovered ? Theme.colors.secondary : Theme.colors.primary

      Behavior on width {
        NumberAnimation { 
          duration: 100
        }
      }

      Behavior on height {
        NumberAnimation {
          duration: 100
        }
      }
    }
    
    HoverHandler { id: sliderHover; cursorShape: Qt.PointingHandCursor }
  }
}

