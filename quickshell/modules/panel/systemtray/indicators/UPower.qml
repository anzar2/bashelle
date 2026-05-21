pragma ComponentBehavior: Bound
import qs.services
import qs.components
import qs.config
import QtQuick

StatusItem {
  id: upower
  property bool isPinned: Config.systemTray.items.pinned.includes("upower")
  text: UPower.percentage
  textItem.visible: Config.upower.showPercentage
  nerdIcon: NerdIcon { text: UPower.icon } 
  visible: UPower.device.isLaptopBattery && isPinned
}
