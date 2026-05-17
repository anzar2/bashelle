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
    nerdIcon: NerdIcon { text: "󰒫" }
    onClicked: root.player.previous()
    color: "transparent"
  }
  
  SButton {
    id: _pause
    Component { id: pauseIcon; NerdIcon { text: "" } }
    Component { id: playIcon; NerdIcon { text: "" } }
    nerdIcon: root.player.playbackState == MprisPlaybackState.Playing ? pauseIcon : playIcon
    onClicked: root.player.togglePlaying()
    color: "transparent"
  }
  
  SButton { 
    id: _next

    nerdIcon: NerdIcon { text: "󰒬" }
    onClicked: root.player.next()
    color: "transparent"
  }

  Item { Layout.fillWidth: true }
}

