import QtQuick
import qs.theme

SRectangle {
  id: bg
  property bool loading: false
  property color fillColor: Theme.colors.primary
  property real speed: 900
  property alias fillBar: fill

  implicitHeight: 2
  implicitWidth: parent.width

  SRectangle {
    id: fill
    implicitWidth: parent.width * 0.25
    implicitHeight: parent.height
    radius: parent.radius
    color: bg.loading ? bg.fillColor : "transparent"
    colorAnimated: true
  }

  SequentialAnimation {
    running: bg.loading
    loops: Animation.Infinite
    
    NumberAnimation {
      target: fill
      property: "x"
      to: bg.width - fill.width
      duration: bg.speed
      easing.type: Easing.InOutQuad
    }


    NumberAnimation {
      target:fill
      to: 0
      property: "x"
      duration: bg.speed
      easing.type: Easing.InOutQuad
    }
  }
}
