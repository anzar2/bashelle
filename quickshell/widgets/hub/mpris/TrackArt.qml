pragma ComponentBehavior: Bound
import qs.components
import QtQuick
import Quickshell.Services.Mpris
import QtQuick.Effects

Item {
  id: root
  property MprisPlayer player
  opacity: player.trackArtUrl !== "" ? 0.3 : 0
  anchors.fill: parent

  Behavior on opacity {
    NumberAnimation {}
  }

  SRectangle {
    id: rectMask
    anchors.fill: parent
    visible: false
    layer.enabled: true
  }

  Image {
    id: image
    source: root.player.trackArtUrl
    fillMode: Image.PreserveAspectCrop
    anchors.fill: parent
    opacity: 0.8
    layer.enabled: true
    layer.effect: MultiEffect {
      maskEnabled: true
      maskSource: rectMask 
    }
  } 
}
