pragma ComponentBehavior: Bound
import QtQuick
import qs.theme
import qs.config
import QtQuick.Effects

Rectangle {
  id: root
  default property alias items: _items.data
  property bool showBorder: false
  property bool shadowEnabled: false
  property bool colorAnimated: true
  property bool animated: false
  property int padding: 0

  border.width: showBorder ? 1.3 : 0
  border.color: Config.theme === "light" ? Theme.colors.surface_container_high : Theme.colors.surface_container

  color: Theme.colors.surface
  radius: 16

  layer.enabled: true
  antialiasing: true

  layer.effect: MultiEffect {
    shadowEnabled: root.shadowEnabled
    shadowBlur: 0.3
    shadowOpacity: 0.5
  }
  
  Item {
    id: _items
    anchors.fill: parent
    anchors.margins: root.padding
  }
  

  Behavior on color {
    enabled: false
    ColorAnimation {
      duration: 200
    }
  }

  Behavior on implicitHeight {
    enabled: root.animated
    NumberAnimation {
      duration: 250
      easing.type: Easing.OutCubic
    }
  }

  Behavior on implicitWidth {
    enabled: root.animated
    NumberAnimation {
      duration: 350
      easing.type: Easing.OutBack
    }
  }


  Behavior on scale {
    enabled: root.animated
    NumberAnimation {
      duration: 250
      easing.type: Easing.OutBack
    }
  }
}
