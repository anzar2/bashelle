import QtQuick.Controls
import Quickshell.Widgets
import QtQuick

import qs.Theme
import qs.Components

MenuItem {
  id: menuitem
  topInset: 2
  bottomInset: 2

  property alias nerdIcon: _nerdIcon
  property alias textItem: _textItem

  property color backgroundColor: highlighted ? 
    Styles.button.secondary.backgroundHighlight : 
    Styles.button.surface_container_lowest.background

  property color foregroundColor: highlighted ? 
    Styles.button.secondary.foregroundHighlight : 
    Styles.button.surface_container_lowest.foreground


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
      implicitSize: visible ? 14 : 0
    }

    NerdIcon { 
      id: _nerdIcon
      color: menuitem.foregroundColor
      visible: text !== ""
      size: 11
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
