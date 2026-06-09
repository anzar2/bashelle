import Quickshell.Services.UPower
import QtQuick

import qs.Services.Notifications
import qs.Utils

QtObject {
  enum Level { Normal, Low, VeryLow, Unknown }
  property UPowerDevice device: UPower.displayDevice
  property real percentage: Math.round(device.percentage * 100)
  property bool charging: device.state == UPowerDeviceState.Charging
  
  property int level: {
    if (percentage >= 26 && percentage <= 100) {
      return BatteryDevice.Level.Normal
    }
    if (percentage >= 16 && percentage <= 25) {
      return BatteryDevice.Level.Low
    }
    if (percentage <= 15) {
      return BatteryDevice.Level.VeryLow
    }
    return BatteryDevice.Level.Unknown
  }

  property string icon: {
    if (charging) return NerdIcons.plugged
    if (percentage == 100) return ""
    if (percentage >= 60) return ""
    if (percentage >= 30) return ""
    if (percentage >= 15) return ""
    return ""
  }

  onLevelChanged: {
    if (device.ready && device && !charging) {
      
      if (level === BatteryDevice.Level.Low) {
        Notifications.send({
          appName:    "Power Service",
          icon:       "system-shutdown",
          summary:    `Battery low (${percentage}%)`,
          body:       "Charge your device soon.",
          attributes: `{ "image-path": <"battery-low"> }`,
          timeout:    0
        })
      }

      if (percentage === BatteryDevice.Level.VeryLow) {
        Notifications.send({
          appName:    "Power Service",
          icon:       "system-shutdown",
          summary:    `Battery very low (${percentage}%)`,
          body:       "Charge your device soon.",
          attributes: `{ "image-path": <"battery-empty"> }`,
          timeout:    0
        })
      }
    }
  }
}
