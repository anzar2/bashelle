import qs.components
import Quickshell.Services.Mpris
import QtQuick
import qs.theme
import QtQuick.Layouts
import qs.services

Loader {
  sourceComponent: ColumnLayout {
    implicitWidth: parent.width
    implicitHeight: parent.height
    spacing: 8
    
    SRectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      visible: Mpris.players.values.length === 0

      Column {
        anchors.centerIn: parent
        SText {
          text: ""
          anchors.horizontalCenter: parent.horizontalCenter
          font.pointSize: 32
        }
        
        SText {
          text: "Sin reproductores"
          size: 8
        }
      }
    }

    
    SListView {
      id: playersList
      Layout.fillWidth: true
      Layout.fillHeight: true
      visible: Mpris.players.values.length > 0
      model: Mpris.players
      delegate: Item {
        id: player
        required property MprisPlayer modelData
        implicitWidth: parent.width
        implicitHeight: 137


        TrackArt {
          player: player.modelData
        }

        SRectangle {
          anchors.fill: parent
          color: Qt.alpha(Theme.colors.surface_container, 0.8)
          padding: 8
          
          ColumnLayout {
            anchors.fill: parent
            spacing: 16
            
            TrackInfo {
              Layout.fillWidth: true
              player: player.modelData
            }
          
            TrackLength {
              Layout.fillWidth: true
              player: player.modelData
            }

            TrackControls {
              Layout.fillWidth: true
              player: player.modelData
            }
          }
        }
      }
    }

  }
}
