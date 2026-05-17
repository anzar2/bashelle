pragma Singleton
import Quickshell.Bluetooth
import QtQuick
import qs.utils

Service {
  id: service
  name: "Bluetooth"
  
  property BluetoothAdapter defaultAdapter: Bluetooth?.defaultAdapter ?? null
  property bool enabled: defaultAdapter?.enabled ?? false

  property list<BluetoothDevice> devices: defaultAdapter?.devices.values
                                          .filter(d => !d.blocked && d.icon !== "") ?? []
  
                                          

  property list<BluetoothDevice> connectedDevices: devices.filter(d => d.connected)


  property bool hasConnections: connectedDevices.length > 0
  
  property string icon: hasConnections ? 
    NerdIcons.bluetooth_alt_connected :  
    NerdIcons.bluetooth_alt

  

  function toggle() { defaultAdapter.enabled = !defaultAdapter.enabled }
  
  function scan() { 
    defaultAdapter.discovering = true 
    scanTimer.restart()
  }

  Timer {
    id: scanTimer
    interval: 8000
    onTriggered: service.defaultAdapter.discovering = false
  }
}
