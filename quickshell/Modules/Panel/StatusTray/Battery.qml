pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.Components
import qs.Components.Controls
import qs.Services.UPower
import qs.Config

Loader {
  id: root
  required property var modelData
  
  active: (UPower.battery.device && UPower.battery.device.ready && modelData.active)
  visible: (!modelData.reactive || !UPower.battery.charging)
    
  Layout.minimumWidth: 24
  Layout.alignment: Qt.AlignCenter
  Layout.fillWidth: Config.panel.isVertical()
  Layout.fillHeight: Config.panel.isHorizontal()

  sourceComponent: SButton {
    icon: NerdIcon {
      text: UPower.battery.icon
      size: 10.8
    }
    
    padding: 5
    flow: Config.panel.getFlow()
    text: UPower.battery.percentage
    textItem.visible: root.modelData.showPercentage
    fontSize: 7.7
  }
}
