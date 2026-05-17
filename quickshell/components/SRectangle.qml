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
  border.color: Config.appearance.theme === "light" ? Theme.colors.surface_container_high : Theme.colors.surface_container

  color: Theme.colors.surface
  radius: Config.appearance.radius

  layer.enabled: Config.appearance.shadows

  layer.effect: MultiEffect {
    shadowEnabled: root.shadowEnabled
    shadowBlur: 0.5
    shadowOpacity: 0.5
  }
  
  Item {
    id: _items
    anchors.fill: parent
    anchors.margins: root.padding
  }
  

  Behavior on color {
    enabled: root.animated
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
