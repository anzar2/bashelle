import qs.components
import qs.services.pipewire
import qs.services
import QtQuick

OsdComponent {
  controller: Widgets.audioOsd
  onMouseEntered: Osd.audioTimer.stop()
  onMouseExited: Osd.audioTimer.restart()
  
  icon: Audio.sink.icon
  value: Audio.sink.rawVolume
  label: Audio.sink.volume
  onMoved: (v) => Audio.sink.setVolume(v)
}
