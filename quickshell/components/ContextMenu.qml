import QtQuick
import QtQuick.Layouts

SRectangle {
  id: contextMenu
  property var model
  
  visible: false
  implicitHeight: column.height + padding * 2
  implicitWidth: 150
  padding: 4
  showBorder: true
  shadowEnabled: true

  Column {
    id: column
    width: parent.width

    Repeater {
      model: contextMenu.model
      delegate: SButton {
        required property var modelData
        implicitWidth: parent.width
        text: modelData.text
        onClicked: modelData.triggered()
        nerdIcon.text: modelData.nerdIcon
        textSize: 10
      }
    }
  }
}