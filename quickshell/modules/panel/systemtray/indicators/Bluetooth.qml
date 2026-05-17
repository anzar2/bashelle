import qs.services
import qs.components
import qs.utils
import qs.config

StatusItem {

  readonly property bool hasConnection: Bt.hasConnections
  property var connectedDevices: Bt.connectedDevices
  property bool active: false

  property bool showName: Config.bluetooth.showName
  readonly property bool isPinned: Config.systemTray.items.pinned.includes("bluetooth")

  text: hasConnection ? `${connectedDevices[0].name}` : `${connectedDevices.length} Devices`
  visible: Bt.defaultAdapter && hasConnection || isPinned
  textItem.visible: (hasConnection && showName) && !Config.panel.isVertical()
  opacity: hasConnection ? 1 : 0.5
  
  nerdIcon: NerdIcon { text: Bt.icon } 
}
