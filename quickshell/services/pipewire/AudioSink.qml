import Quickshell.Services.Pipewire
import QtQuick
import qs.utils
import qs.services

QtObject {
  id: root
  property PwNode device: Pipewire.defaultAudioSink ?? null
  property real rawVolume: device?.audio.volume ?? null
  property bool muted: device?.audio.muted ?? null
  property real volume: Math.round(rawVolume * 100)

  onRawVolumeChanged: {
    Widgets.audioOsd.show()
    OsdSettings.audioTimer.restart()
  }

  onMutedChanged: {
    Widgets.audioOsd.show()
    OsdSettings.audioTimer.restart()
  }

  property string icon: {
    if (muted) return NerdIcons.volume_muted
    if (volume > 50) return NerdIcons.volume_high
    if (volume > 10) return NerdIcons.volume_mid
    return NerdIcons.volume_low
  }

  function setNode(node: PwNode) {
    Pipewire.preferredDefaultAudioSink = node
    device = node
  }

  function toggleMute() {
    device.audio.muted = !device.audio.muted
  }

  function setVolume(v: real) {
    device.audio.volume = v 
  }
}
