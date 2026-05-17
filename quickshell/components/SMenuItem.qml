import QtQuick.Controls
import Quickshell.Widgets
import QtQuick
import qs.theme

MenuItem {
  id: menuitem
  
  property alias nerdIcon: _nerdIcon
  property alias textItem: _textItem

  property color backgroundColor: highlighted ? 
    Styles.button.clear.backgroundHighlight : 
    Styles.button.clear.background

  property color foregroundColor: highlighted ? 
    Styles.button.clear.foregroundHighlight : 
    Styles.button.clear.foreground


  background: SRectangle {
    layer.enabled: false
    color: menuitem.backgroundColor
  }

  contentItem: Row {
    spacing: 6
    opacity: menuitem.enabled ? 1 : 0.5

    IconImage {
      id: _icon
      source: menuitem.icon.source
      visible: menuitem.icon.source.toString() !== ""
      implicitSize: visible ? 16 : 0
    }

    NerdIcon { 
      id: _nerdIcon
      color: menuitem.foregroundColor
      visible: text !== ""
    }

    SText {
      id: _textItem
      text: menuitem.text 
      size: 9
      color: menuitem.foregroundColor
      elide: Text.ElideRight
      width: parent.width
    }
  }


  HoverHandler { cursorShape: Qt.PointingHandCursor }
}
