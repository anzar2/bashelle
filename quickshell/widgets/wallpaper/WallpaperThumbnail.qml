pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import qs.components
import qs.theme

Item {
  id: root
  property bool showBorder: false
  property url url: ""
  signal clicked()

  implicitWidth: 180
  implicitHeight: 90

  layer.enabled: true
  layer.effect: MultiEffect {
    shadowEnabled: true
    shadowBlur: 0.3
    shadowOpacity: 0.5
  }

  

  SRectangle {
    id: rectMask
    anchors.fill: parent
    layer.enabled: true
    visible: false
  }


  Image {
    anchors.fill: parent
    source: parent.url
    sourceSize: Qt.size(parent.width, parent.height)
    fillMode: Image.PreserveAspectCrop
    layer.enabled: true
    layer.effect: MultiEffect {
      maskEnabled: true
      maskSource: rectMask
    }
  }
  
  Behavior on scale {
    NumberAnimation {}
  }

  HoverHandler {
    cursorShape: Qt.PointingHandCursor
  }

  TapHandler {
    onTapped: parent.clicked()
  }
}