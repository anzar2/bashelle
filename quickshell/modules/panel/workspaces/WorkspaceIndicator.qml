import qs.components
import QtQuick
import qs.theme

Item {
  id: root
  property alias background: _background
  property alias dot: _dot
  property int radius: 0
  property bool hovered: hoverHandler.hovered
  property bool pressed: tapHandler.pressed
  property bool focused: false
  property NumberAnimation scaleAnimation: NumberAnimation { easing.type: Easing.OutBack }

  signal clicked()

  Behavior on implicitWidth { NumberAnimation { easing.type: Easing.OutBack; duration: 350 } }
  Behavior on implicitHeight { NumberAnimation { easing.type: Easing.OutBack; duration: 350 } }

  SRectangle {
    id: _background
    anchors.fill: parent
    radius: parent.radius
    color: root.focused ? Theme.colors.primary :  Qt.alpha(Theme.colors.secondary, 0.2)
    z: 0
    animated: true
    Behavior on scale {
      animation: root.scaleAnimation
    }
  }

  SRectangle {
    id: _dot
    implicitHeight: Math.round(_background.height / 5)
    implicitWidth: Math.round(_background.width / 5)
    anchors.centerIn: parent
    radius: parent.radius
    color: root.focused ? Theme.colors.surface : Qt.alpha(Theme.colors.primary, 0.2)
    z: 1
  }

  TapHandler {
    id: tapHandler
    onSingleTapped: parent.clicked()
  }

  HoverHandler { id: hoverHandler }
}
