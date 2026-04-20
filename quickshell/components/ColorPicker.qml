import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import qs.config

SButton {
  id: button
  property alias window: colorDialog
  property bool focused: false
  
  surface.showBorder: true
  nerdIcon.text: ""
  nerdIcon.color: colorDialog.selectedColor
  onClicked: {
    colorDialog.open()
    focused = true
  }

  ColorDialog {
    id: colorDialog
    title: "colordialog"
    
  }
}