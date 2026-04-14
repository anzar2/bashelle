import qs.components
import qs.config
import QtQuick.Layouts

PopupMenu {
  id: cosa
  background.width: 100
  y: -height

  SButton {
    Layout.fillWidth: true
    text: qsTr("Fit")
    onClicked: Config.wallpapers.resizeMode = "fit" 
  }

  SButton {
    Layout.fillWidth: true
    text: qsTr("Crop")
    onClicked: Config.wallpapers.resizeMode = "crop" 
  }

  SButton {
    Layout.fillWidth: true
    text: qsTr("Center")
    onClicked: Config.wallpapers.resizeMode = "no" 
  }
}