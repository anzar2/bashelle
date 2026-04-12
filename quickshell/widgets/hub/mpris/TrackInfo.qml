import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.components

ColumnLayout {
  id: trackInfo
  property MprisPlayer player
  clip: true
  implicitHeight: 30
  spacing: 0

  SText {
    Layout.maximumWidth: trackInfo.parent.width
    text: trackInfo.player.trackTitle
    size: 10
    font.bold: true
  }

  SText {
    Layout.maximumWidth: trackInfo.parent.width
    text: trackInfo.player.trackArtist
    size: 8
  }
}

