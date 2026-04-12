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
  implicitWidth: 150
  implicitHeight: 8

  handle: Item {}

  background: Item {
    width: slider.availableWidth
    height: slider.availableHeight

   SRectangle {
      id: bg
      anchors.fill: parent
      color: Theme.colors.surface_container_high
    }

    SRectangle {
      id: fill
      width: slider.visualPosition * parent.width
      height: parent.height
      color: sliderHover.hovered ? Theme.colors.secondary : Theme.colors.primary

      Behavior on width {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
      }
    }
    
    HoverHandler { id: sliderHover; cursorShape: Qt.PointingHandCursor }
  }
}

