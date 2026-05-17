pragma ComponentBehavior: Bound
import qs.services
import qs.components
import qs.utils
import qs.config

StatusItem {
  id: network

  // textItem.visible: !Config.panel.isVertical() || Config.systemTray.indicators.network.visible
  
  nerdIcon: NerdIcon {
    text: NerdIcons.web_remove
  } 
}
