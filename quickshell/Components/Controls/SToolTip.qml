import QtQuick
import QtQuick.Controls

import qs.Components

ToolTip {
  id: tooltip
  property alias textItem: text

  popupType: Popup.Window
  delay: 500
  
  width: Math.min(implicitWidth, 300)
  
  background: SRectangle {
    showBorder: true
    shadowEnabled: true
  }

  contentItem: SText {
    id: text
    text: tooltip.text
    wrapMode: Text.WordWrap
  }
}
