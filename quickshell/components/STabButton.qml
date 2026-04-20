import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import qs.config
import qs.theme

TabButton {
  id: button
  property alias nerdIcon: _nerdIcon
  property alias textItem: _textItem
  

  implicitWidth: contentItem.implicitWidth + padding * 4
  font.family: Config.fontFamily
  padding: 4

  background: SRectangle { color: "transparent" }
  contentItem: RowLayout {
    NerdIcon {
      id: _nerdIcon
      visible: text !== ""
      Layout.alignment: Qt.AlignCenter
    }

    SText {
      id: _textItem
      text: button.text
      font: button.font
      visible: text !== ""
    }
  }
  HoverHandler { cursorShape: Qt.PointingHandCursor }
}