pragma ComponentBehavior: Bound
import QtQuick
import qs.Theme
import qs.Config
import QtQuick.Effects

Rectangle {
  id: root
  property bool showBorder:    false
  property bool shadowEnabled: false
  property bool colorAnimated: false
  property real backgroundOpacity: 1.0
  property bool animated: false

  border.width: showBorder ? 1 : 0
  border.color: Theme.colors.surface_container_low

  color: Qt.alpha(Theme.colors.surface_container_lowest, Math.min(backgroundOpacity, 1.0))    
  radius: Config.appearance.radius

  layer.enabled: Config.appearance.shadows

  layer.effect: MultiEffect {
    shadowEnabled: root.shadowEnabled
    shadowBlur: 0.5
    shadowOpacity: 0.5
    antialiasing: root.antialiasing
  }
  

  Behavior on color {
    enabled: root.colorAnimated
    ColorAnimation {
      duration: 200
    }
  }

  Behavior on implicitHeight {
    enabled: root.animated
    NumberAnimation {
      duration: 200
      easing.type: Easing.OutCubic
    }
  }

  Behavior on implicitWidth {
    enabled: root.animated
    NumberAnimation {
      duration: 200
      easing.type: Easing.OutCubic
    }
  }


  Behavior on scale {
    enabled: root.animated
    NumberAnimation {
      duration: 100
      easing.type: Easing.OutCubic
    }
  }
}
