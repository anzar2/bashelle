pragma ComponentBehavior: Bound
import QtQuick.Controls
import QtQuick

import qs.Theme
import qs.Config

Slider {
  id: slider
  property bool highlighted: slider.hovered || slider.pressed
  stepSize: 0.01
  snapMode: Slider.SnapAlways
  implicitHeight: 16
  
  background: Item {
    Rectangle {
      id: bg
      implicitHeight: 2
      radius: Config.appearance.radius
      implicitWidth: slider.width
      anchors.verticalCenter: parent.verticalCenter
      color: Theme.colors.surface_container_high
    }

    Rectangle {
      id: fill
      implicitHeight: (bg.height * 2)
      implicitWidth: slider.width * slider.value

      anchors.verticalCenter: parent.verticalCenter
      color: Theme.colors.primary
      radius: bg.radius
    }
  }

  handle: Rectangle {
    x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
    y: slider.leftPadding + slider.availableHeight / 2 - height / 2
    scale: slider.highlighted ? 1.12 : 1
    radius: Config.appearance.radius
    implicitWidth:  12
    implicitHeight: 12
    border.width: 2
    border.color: Theme.colors.primary
    color: Theme.colors.surface
    
    Behavior on scale {
      NumberAnimation {
        easing.type: Easing.OutQuad
        duration: 150
      }
    }
  }

  HoverHandler {cursorShape:Qt.PointingHandCursor}
}
