import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

import qs.Config
import qs.Theme
import qs.Components

TabButton {
  id: button
  property string identifier
  property alias nerdIcon: _nerdIcon
  property alias textItem: _textItem
  implicitWidth: contentItem.implicitWidth + padding * 4
  font.family: Config.appearance.fontFamily
  padding: 4

  background: SRectangle { color: "transparent" }
  contentItem: Item {
    implicitWidth: _row.implicitWidth
    implicitHeight: _row.implicitHeight

  RowLayout {
    id: _row
    anchors.centerIn: parent
    spacing: 8

    NerdIcon {
      id: _nerdIcon
      visible: text !== ""

      opacity: button.checked ? 1 : 0.7
      color: button.checked ?
          Theme.colors.primary :
          Theme.colors.on_surface
    }
    SText {
      id: _textItem
      text: button.text
      visible: text !== ""
      size: 9
      opacity: button.checked ? 1 : 0.7
      color: button.checked ?
          Theme.colors.primary :
          Theme.colors.on_surface
    }
  }
}
  HoverHandler { cursorShape: Qt.PointingHandCursor }
}
