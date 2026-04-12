import qs.components
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

ColumnLayout {
  id: root
  property MprisPlayer player
  
  implicitHeight: 0
  spacing: 3

  SSlider {
    Layout.fillWidth: true
    backgroundRect.showBorder: true
    from: 0
    implicitHeight: 11
    to: 1
    value: pressed ? value : root.player.position / root.player.length
    onPressedChanged: {
      if (!pressed) {
        root.player.position = value * root.player.length
      }
    }
  }

  RowLayout {
    Layout.fillWidth: true
    implicitHeight: 20

    SText {
      size: 8
      text: root.secondsToTimeString(root.player.position)
    }

    Item { Layout.fillWidth: true }
    
    SText {
      size: 8
      text: root.secondsToTimeString(root.player.length)
    }
  }

  Timer {
    running: root.player.playbackState == MprisPlaybackState.Playing
    interval: 1000
    repeat: true
    onTriggered: root.player.positionChanged()
  }
  
  // seconds: 60
  function secondsToTimeString(seconds: int): string {
    const h = Math.floor(seconds / 3600)
    const m = Math.floor((seconds % 3600) / 60)
    const s = Math.floor(seconds % 60)

    const mm = String(m).padStart(2, '0')
    const ss = String(s).padStart(2, '0')

    return h > 0 ? `${h}:${mm}:${ss}` : `${mm}:${ss}`
  }
}
