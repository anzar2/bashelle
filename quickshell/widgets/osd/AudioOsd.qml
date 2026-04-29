import qs.components
import qs.services
import QtQuick

Osd {
  controller: Widgets.audioOsd
  onMouseEntered: OsdSettings.audioTimer.stop()
  onMouseExited: OsdSettings.audioTimer.restart()
  
  icon: Audio.sink.icon
  value: Audio.sink.rawVolume
  label: Audio.sink.volume
  onMoved: (v) => { Audio.sink.setVolume(v) }
}