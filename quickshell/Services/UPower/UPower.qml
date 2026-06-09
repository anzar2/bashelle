pragma Singleton

import Quickshell.Services.UPower
import QtQuick

import qs.Services
import qs.Utils

Service {
  id: service
  name: "UPower"
  onStart: ready = true

  // Battery
  property BatteryDevice battery: BatteryDevice {}

  // Power Profiles
  property bool hasPowerProfiles: PowerProfiles.hasPerformanceProfile
  property var holdingPowerProfiles: PowerProfiles.holds
  property int currentPowerProfile: PowerProfiles.profile
 
  property string profileIcon: {
    switch (currentPowerProfile) {
      case PowerProfile.Performance:
        return NerdIcons.rocket
      case PowerProfile.Balanced:
        return NerdIcons.balance
      case PowerProfile.PowerSaver:
        return NerdIcons.leaf
    }
  }

  property string profileString: {
    switch(currentPowerProfile) {
      case PowerProfile.Balanced:
        return "Balanced"
      case PowerProfile.PowerSaver:
        return "Power saver"
      case PowerProfile.Performance:
        return "Perfomance"
    }
  }
  
}
