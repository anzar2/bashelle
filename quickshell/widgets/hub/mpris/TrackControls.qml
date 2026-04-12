import qs.components
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

RowLayout { 
  id: root
  property MprisPlayer player
  
  Item { Layout.fillWidth: true }
  
  SButton { 
    id: _prev
    nerdIcon.text: "󰒫" 
    onClicked: root.player.previous()
    color: "transparent"
  }
  
  SButton {
    id: _pause
    nerdIcon.text: root.player.playbackState == MprisPlaybackState.Playing ? "" : ""
    onClicked: root.player.togglePlaying()
    color: "transparent"
  }
  
  SButton { 
    id: _next
    nerdIcon.text: "󰒬" 
    onClicked: root.player.next()
    color: "transparent"
  }

  Item { Layout.fillWidth: true }
}

