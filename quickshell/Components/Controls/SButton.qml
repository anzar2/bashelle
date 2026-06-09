import QtQuick.Controls
import QtQuick
import QtQuick.Layouts

import qs.Theme
import qs.Components
import qs.Config

Control {
  id: button
  signal clicked()
  property alias textItem: _text
  property bool highlighted: false
  property bool pressed: tapHandler.pressed
  property string text: ""

  property Component icon: null
  property real columnSpacing: 4
  property real rowSpacing:    4
  property real fontSize: 9
  property bool showIcon: true
  
  property var    style: Styles.button.surface
  property color  backgroundColor: (hovered || highlighted) ? style.backgroundHighlight : style.background
  property color  foregroundColor: (hovered || highlighted) ? style.foregroundHighlight : style.foreground
  property bool   showBorder: false

  property int flow: Flow.LeftToRight
  property int layoutDirection: Qt.LeftToRight
  property int alignment: Qt.AlignCenter

  padding: 6
  scale: pressed ? 0.99 : 1
  opacity: enabled ? 1 : 0.5
  font.family: Config.appearance.fontFamily
  font.pointSize: fontSize * Config.appearance.fontScale
  
  background: SRectangle {
    animated: true
    color: button.backgroundColor
    clip: true
    showBorder: button.showBorder
  }

  contentItem: GridLayout {
    layoutDirection: button.layoutDirection
    flow: button.flow
    columnSpacing: button.columnSpacing; rowSpacing: button.rowSpacing;

    Loader {
      id: iconLoader
      sourceComponent: button.icon
      active:  button.icon && button.showIcon
      visible: active

      Layout.alignment: button.alignment
    }

    SText {
      id: _text
      text: button.text
      font: button.font
      color: button.foregroundColor
      visible: text != ""
      Layout.alignment: button.alignment
    }
  }

  TapHandler   { id: tapHandler; onTapped: button.clicked(); enabled: button.enabled }
  HoverHandler { cursorShape: Qt.PointingHandCursor; enabled: button.enabled }
}
