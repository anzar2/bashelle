pragma ComponentBehavior: Bound
import qs.services.pipewire
import qs.components
import qs.services
import qs.config

StatusItem {
  id: mic
  property bool isPinned: Config.systemTray.items.pinned.includes("mic")
  property bool inUse: Audio.sourceTracker.linkGroups.length > 0
  property bool active: Widgets.micSettings.active
  property bool showPercentage: Config.pipewire.mic.showPercentage 
  
  text: Audio.source.volume
  textItem.visible: showPercentage || active
  nerdIcon: NerdIcon {
    text: Audio.source.icon
    color: mic.textItem.color
  } 
  
  visible: inUse || isPinned
  onRightClicked: Audio.source.toggleMute()
  highlighted: active
  onClicked: Widgets.micSettings.toggle()
}
