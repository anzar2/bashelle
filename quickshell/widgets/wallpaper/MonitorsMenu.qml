pragma ComponentBehavior: Bound
import qs.components
import QtQuick.Layouts
import QtQuick
import Quickshell

PopupMenu {
  id: menu
  property string label: qsTr("All")
  property list<ShellScreen> monitors: Quickshell.screens
  background.width: 100
  y: -height

  SButton {
    Layout.fillWidth: true
    text: qsTr("All")
    onClicked: {
      menu.monitors = Quickshell.screens
      menu.label = qsTr("All")
    }
  }

  Repeater {
    model: Quickshell.screens
    delegate: SButton {
      required property ShellScreen modelData
      Layout.fillWidth: true
      text: modelData.name
      onClicked: { 
        menu.monitors = [modelData]
        menu.label = modelData.name
      }
    }
  }
}