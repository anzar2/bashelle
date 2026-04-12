import QtQuick
import QtQuick.Layouts
import qs.components 
import qs.theme
import qs.config

SRectangle  {
  id: root
  property string placeholder: "Write a nice text..."
  property alias text: textInput.text
  implicitWidth: parent.width
  implicitHeight: 40
  color: Theme.colors.surface_container
  showBorder: true
  border.color: Theme.colors.surface_container_high

 
  RowLayout {
    id: inputRow
    anchors.centerIn: parent
    spacing: 12

    
    TextInput {
      id: textInput
      color: Theme.colors.on_surface
      text: root.text
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.alignment: Qt.AlignVCenter
      visible: true
      font.pointSize: Config.fontScale * 11
    }
  }

  SText {
    color: Qt.alpha(Theme.colors.on_surface, 0.8)
    text: root.placeholder
    size: 11
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 12
    visible: textInput.length < 1
  }
}

