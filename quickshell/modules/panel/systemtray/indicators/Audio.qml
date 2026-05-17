import qs.services.pipewire
import qs.components
import qs.services
import qs.config

StatusItem {
  readonly property bool isPinned: Config.systemTray.items.pinned.includes("audio")
  property bool inUse: Audio.sinkTracker.linkGroups.length > 0
  property bool active: Widgets.audioSettings.active
  property bool showPercentage: Config.pipewire.audio.showPercentage 
  text: Audio.sink.volume
  textItem.visible: active || showPercentage
  
  visible: (inUse || Audio.sink.muted) || isPinned
    
  nerdIcon: NerdIcon {
    text: Audio.sink.icon
  }

  onClicked: Widgets.audioSettings.toggle()
  highlighted: active
}
