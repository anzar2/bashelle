pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import qs.config
import qs.theme
import qs.services
import qs.components

SPanelWindow {
  id: root
  property var borderWidth: Config.frames.enabled ? Config.frames.width : 0
  WlrLayershell.layer: WlrLayer.Top
  color: "transparent"
  visible: true
  

  mask: Region { 
    item: container
    intersection: Intersection.Xor
  }


  anchors {
    top: true
    bottom: true
    right: true
    left: true
  }

  Item {
    id: container
    anchors.fill: parent
    layer.enabled: true
    layer.effect: MultiEffect {
      shadowEnabled: true
      shadowBlur: 0.3
    }

    SRectangle {
      anchors.fill: parent
      layer.enabled: true
      layer.effect: MultiEffect {
        maskSource: maskShape
        maskEnabled: true
        maskInverted: true
      }
      radius: 0
    }


    Item {
      id: maskShape
      anchors.fill: parent
      layer.enabled: true
      visible: false
      
      Rectangle {  
        anchors.fill: parent
        anchors.margins: root.borderWidth
        color: "red"
        radius: Config.frames.radius
      
      }
    }
  }
}
