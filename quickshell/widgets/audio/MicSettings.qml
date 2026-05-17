import qs.components
import qs.services.pipewire
import qs.utils
import qs.services

AudioPanel {
  controller: Widgets.micSettings
  onFocusLost: Widgets.micSettings.hide()
  devices: Audio.inputDevices
  controlIcon: Audio.source.icon
  devicesIcon: NerdIcons.monitor_speaker
  node: Audio.source.device
  onDeviceSelected: node => Audio.source.setNode(node)
  control: AudioControl {
    label.text:       Audio.source.volume
    slider.value:     Audio.source.rawVolume
    slider.onMoved:   Audio.source.setVolume(slider.value)
    button.onClicked: Audio.source.toggleMute()
    button.nerdIcon:  NerdIcon { text: Audio.source.icon }
  }
  mixer: MixerPanel {
    scope: "target"
    model: Audio.sourceTracker.linkGroups
  }
}
