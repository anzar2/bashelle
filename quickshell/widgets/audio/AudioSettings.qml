import qs.components
import qs.services.pipewire
import qs.utils
import qs.services

AudioPanel {
  controller: Widgets.audioSettings
  onFocusLost: Widgets.audioSettings.hide()
  devices: Audio.outputDevices
  node: Audio.sink.device
  controlIcon: Audio.sink.icon
  devicesIcon: NerdIcons.monitor_speaker
  onDeviceSelected: node => Audio.sink.setNode(node)
  control: AudioControl {
    slider.value:     Audio.sink.rawVolume
    slider.onMoved:   Audio.sink.setVolume(slider.value)
    button.onClicked: Audio.sink.toggleMute()
    button.nerdIcon:  NerdIcon { text: Audio.sink.icon }
  }
  mixer: MixerPanel {
    scope: "source"
    model: Audio.sinkTracker.linkGroups
  }
}
