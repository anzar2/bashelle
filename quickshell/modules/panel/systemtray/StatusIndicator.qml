import qs.components
import qs.theme
import qs.config
import QtQuick
import qs.services
import qs.utils

SButton {
  id: controlCenter
  property alias iconsFlow: _iconsFlow
  property real iconSize: 12
  color: Theme.colors.surface_container_low
  surface.showBorder: true
    
  Behavior on implicitHeight {
    NumberAnimation {
      easing.type: Easing.OutBack
      duration: 450
    }
  }
  
  Behavior on implicitWidth {
    NumberAnimation {
      easing.type: Easing.OutQuart
      duration: 450
    }
  }

  Flow {
    id: _iconsFlow
    anchors.centerIn: parent
    flow: Config.panel.getFlow()
    padding: 4
    spacing: 0
    

    SButton {
      visible: Audio.sourceTracker.linkGroups.length > 0
      nerdIcon.text: Audio.source.icon
      implicitWidth: 25
      nerdIcon.size: controlCenter.iconSize
      padding: parent.padding
      enabled: false
      hoverEnabled: false
    }

    SButton {
      nerdIcon.text: Audio.sink.icon
      implicitWidth: 25
      nerdIcon.size: controlCenter.iconSize
      padding: parent.padding
      enabled: false
      hoverEnabled: false
    }

    SButton {
      nerdIcon.text: UPower.icon
      nerdIcon.rotation: 90
      visible: UPower.device.isLaptopBattery
      implicitWidth: 25
      nerdIcon.size: controlCenter.iconSize
      padding: parent.padding
      enabled: false
      hoverEnabled: false
    }
    
    
  }  
}

