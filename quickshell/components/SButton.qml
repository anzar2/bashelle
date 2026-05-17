pragma ComponentBehavior: Bound
import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.theme
import qs.types
import qs.config

// I'll make this cleaner when the time comes
Button {
  id: button
  property ButtonStyle style: Styles.button.clear

  property alias textItem: _text
  property alias surface: _background
  // property alias tooltip: _tooltip
  property real textSize: 9
  property real iconSize: 14
  property int flow: Flow.LeftToRight
  property int alignment: Qt.AlignCenter
  property int layoutDirection: Qt.LeftToRight
  property color color: highlighted || hovered ? style.backgroundHighlight : style.background  
  property color textColor: highlighted || hovered ? style.foregroundHighlight : style.foreground
  property Component nerdIcon: null
  signal rightClicked()

  opacity: enabled ? 1 : 0.5
  implicitWidth: content.implicitWidth + (padding * 2)
  TapHandler { acceptedButtons: Qt.RightButton; onTapped: button.rightClicked() }
  //
  // SToolTip {
  //   id: _tooltip
  //   visible: button.text != "" && button.hovered
  //   text: button.text
  //   popupType: Popup.Window
  //   y: button.height
  //   delay: 500
  // }

  padding: 6
  hoverEnabled: enabled

  background: SRectangle {
    id: _background
    colorAnimated: false
    color: button.color    
    scale: button.pressed  ? 0.98: 1
  }

  contentItem: GridLayout {
    id: content
    flow: button.flow
    layoutDirection: button.layoutDirection
    rowSpacing: 8
    columnSpacing: 8
    clip: true
    
    Loader {
      active: button.icon.name != ""       
      visible: active
      sourceComponent: IconImage {
        source: Qt.resolvedUrl(button.icon.name)
        implicitSize: 14
      }
    }

    Loader {
      id: nerdIconLoader
      sourceComponent: button.nerdIcon
      active: button.nerdIcon
      visible: active
      Layout.alignment: button.alignment
    }

    SText {
      id: _text
      visible: text !== ""
      text: button.text
      size: button.textSize
      font.bold: button.font.bold
      font.capitalization: button.font.capitalization
      leftPadding: 2
      color: button.textColor
      Layout.fillWidth: true
    }
  }

  HoverHandler { cursorShape: Qt.PointingHandCursor }
}
