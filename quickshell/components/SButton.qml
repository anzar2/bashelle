import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.theme

// I'll make this cleaner when the time comes
Button {
  id: button
  property var style: flat ? flatStyle : fillStyle
  property var flatStyle: ({
    background: "transparent",
    backgroundHovered: Theme.colors.surface_container,
  })

  readonly property var fillStyle: ({
    background: Theme.colors.primary,
    backgroundHovered: Theme.colors.primary,
  })

  property alias textItem: _text
  property alias nerdIcon: _nerdIcon
  property alias surface: _background
  property real textSize: 9
  property int alignment: Qt.AlignCenter
  property int layoutDirection: Qt.LeftToRight
  property color color: hovered ? style.backgroundHovered : style.background   
  property color textColor: flat ? Theme.colors.on_surface_variant : Theme.colors.on_primary
  
  flat: true
  padding: 6
  HoverHandler { cursorShape: Qt.PointingHandCursor }


  background: SRectangle {
    id: _background
    colorAnimated: false
    color: button.color    
    scale: button.pressed  ? 0.98: 1
  }

  contentItem: RowLayout {
    id: content
    layoutDirection: button.layoutDirection
    spacing: 4
    visible: (_nerdIcon.text !== "" || button.text !== "")

    IconImage {
      visible: button.icon.name !== ""
      source: Qt.resolvedUrl(button.icon.name)
      implicitSize: 14
    }
    
    NerdIcon {
      id: _nerdIcon
      visible: text !== ""
      size: 11
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
}
