import QtQuick.Controls

ToolTip {
  id: tooltip
  padding: 8
  popupType: Popup.Window

  background: SRectangle {
    showBorder: true
  }

  contentItem: SText {
    text: tooltip.text
    size: 8
  }
}
