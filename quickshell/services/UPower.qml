pragma Singleton
import Quickshell.Services.UPower
import qs.services
import qs.utils
import qs.config

Service {
  name: "UPower"
  ready: device !== null
  property UPowerDevice device: UPower.displayDevice
  property real percentage: Math.round(device.percentage * 100)
  property bool charging: device.state === UPowerDeviceState.Charging
  property string icon: {
    if (percentage == 100) return NerdIcons.battery_full
    if (charging) return NerdIcons.plugged
    if (percentage > 90) return NerdIcons.battery_90
    if (percentage > 70) return NerdIcons.battery_70
    if (percentage > 60) return NerdIcons.battery_60
    if (percentage > 40) return NerdIcons.battery_40
    if (percentage > 30) return NerdIcons.battery_30
    if (percentage > 25) return NerdIcons.battery_20
    if (percentage > 10) return NerdIcons.battery_10
    return NerdIcons.battery_10
  } 
  

  onPercentageChanged: {
    if (percentage === Config.upower.verylow_threshold && !charging) {
      Notifications.send(
        qsTr("Energy Service"), 
        `${qsTr("Battery too low")} ${percentage}%`
      )
    }
 
    if (percentage === Config.upower.low_threshold && !charging) {
      Notifications.send(
        qsTr("Energy Service"), 
        `${qsTr("Battery low")} ${percentage}%`
      )
    }
   
  }
}
