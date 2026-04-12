import QtQuick.Controls
import QtQuick
import qs.theme
import qs.components

RadioButton {
  id: button
  property alias backgroundRect: _background
  property color indicatorColor: Theme.colors.primary

  background: SRectangle {
    id: _background
    color: button.checked ? Theme.colors.surface_container : "transparent"
    colorAnimated: false
  }

  indicator: SRectangle {
    id: _indicator
    anchors.verticalCenter: parent.verticalCenter
    showBorder: true
    border.color: Theme.colors.surface_container_high
    color: Theme.colors.surface_container
    anchors.left: parent.left
    anchors.margins: 6
    implicitWidth: 12
    implicitHeight: 12

    SRectangle {
      anchors.centerIn: parent
      implicitWidth: parent.width / 2
      implicitHeight: parent.height / 2
      scale: button.checked ? 1 : 0
      color: button.indicatorColor
      animated: true
    }
  }

  contentItem: SText {
    id: _text
    leftPadding: _indicator.width + _indicator.anchors.margins
    text: button.text
    size: button.font.pointSize
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
  }

  HoverHandler { cursorShape: Qt.PointingHandCursor }
}
