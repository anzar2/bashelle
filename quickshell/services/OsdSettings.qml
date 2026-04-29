pragma Singleton
import Quickshell
import QtQuick
import qs.services

Singleton {
  property alias audioTimer: _audioTimer
  
  Timer {
    id: _audioTimer
    interval: 4000
    onTriggered: Widgets.audioOsd.hide()
  }
}