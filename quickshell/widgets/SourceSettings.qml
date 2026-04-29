import Quickshell.Services.Pipewire
import qs.components
import qs.services
import QtQuick

ControlPage {
  
  SText {
    anchors.centerIn: parent
    visible: deviceList.model.length == 0
    text: "No devices found"
    size: 10
  }


  SListView {
    id: deviceList
    spacing: 4
    anchors.fill: parent
    model: Audio.inputDevices
    delegate: SRadioButton {
      required property PwNode modelData
      implicitWidth: parent.width
      text: modelData.description
      checked: Audio.source.device.id === modelData.id
      onClicked: Audio.source.setNode(modelData)
    }
  }
}
