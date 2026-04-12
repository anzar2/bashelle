import qs.components
import qs.theme
import qs.config
import QtQuick
import qs.services
import qs.utils

SRectangle {
  id: controlCenter
  property alias iconsFlow: _iconsFlow
  property real iconSize: 12
  color: Theme.colors.surface_container_low
  showBorder: true

  Flow {
    id: _iconsFlow
    anchors.centerIn: parent
    flow: Config.panel.getFlow()
    padding: 4
    spacing: 0

    SButton {
      nerdIcon.text: Audio.sink.icon
      implicitWidth: 25
      nerdIcon.size: controlCenter.iconSize
      padding: parent.padding
      animated: true
    }
    
    SButton {
      nerdIcon.text: "󱞐"
      nerdIcon.rotation: 90
      implicitWidth: 25
      nerdIcon.size: controlCenter.iconSize
      padding: parent.padding
      animated: true
    }
    
    SButton {
      nerdIcon.text: UPower.icon
      nerdIcon.rotation: 90
      visible: UPower.device.isLaptopBattery
      implicitWidth: 25
      nerdIcon.size: controlCenter.iconSize
      padding: parent.padding
      animated: true
    }
    
  }  
}

