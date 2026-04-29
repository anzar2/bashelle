pragma ComponentBehavior: Bound
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
    spacing: 6
    anchors.fill: parent
    model: Audio.outputDevices
    delegate: SRadioButton {
      required property PwNode modelData
      implicitWidth: parent.width
      text: modelData.nickname
      checked: Audio.sink.device.id === modelData.id
      onClicked: Audio.sink.setNode(modelData)
    }
  }
}
