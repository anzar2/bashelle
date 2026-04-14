import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.theme

Button {
  id: button

  property alias textItem: _text
  property alias nerdIcon: _nerdIcon
  property alias surface: _background
  property real textSize: 10
  property bool animated: false
  property int alignment: Qt.AlignCenter
  property int layoutDirection: Qt.LeftToRight
  property color textColor: Theme.colors.on_surface_variant
  property color color: hovered ? Theme.colors.surface_container : "transparent"

  padding: 6
  HoverHandler { cursorShape: Qt.PointingHandCursor }

  background: SRectangle {
    id: _background
    colorAnimated: false
    animated: button.animated
    color: button.color    
    scale: button.pressed && button.animated ? 0.98: 1
  }

  contentItem: RowLayout {
    id: content
    anchors.left: button.alignment === Qt.AlignLeft ?  _background.left : undefined
    anchors.centerIn: button.alignment === Qt.AlignCenter ? _background : undefined
    anchors.verticalCenter: parent.verticalCenter
    layoutDirection: button.layoutDirection
    spacing: 4
    visible: (_nerdIcon.text !== "" || button.text !== "")

    IconImage {
      visible: button.icon.name !== ""
      source: button.icon.name
      implicitSize: 28
    }
    

    NerdIcon {
      id: _nerdIcon
      visible: text !== ""
      size: 13
      color: button.textColor
      leftPadding: button.alignment === Qt.AlignLeft ? 8 : 0
      Layout.alignment: button.alignment
      z: 99
    }

    SText {
      id: _text
      visible: text !== ""
      text: button.text
      size: button.textSize
      font.bold: button.font.bold
      font.capitalization: button.font.capitalization
      elide: Text.ElideRight
      color: button.textColor
      leftPadding: button.alignment && !_nerdIcon.visible === Qt.AlignLeft ? 8 : 0
      Layout.alignment: button.alignment
      Layout.fillWidth: true
      z: 99
    }
  }

  Behavior on scale {
    enabled: button.animated
    NumberAnimation {
      duration: 150
    }
  } 
}
