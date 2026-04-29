import Quickshell.Services.Pipewire
import QtQuick
import qs.utils
import Quickshell

QtObject {
  id: root
  property PwNode device: Pipewire.defaultAudioSource ?? null
  property real rawVolume: device?.audio?.volume ?? 0
  property real volume: Math.round(rawVolume * 100)
  property bool muted: device?.audio.muted ?? false
 
  property string icon: {
    if (muted || device === null) return NerdIcons.mic_muted
    return NerdIcons.mic
  }

  function setNode(node: PwNode) {
    Pipewire.preferredDefaultAudioSource = node
  }
  function toggleMute() {
    device.audio.muted = !device.audio.muted
  }

  function setVolume(v: real) {
    device.audio.volume = v 
  }
}
