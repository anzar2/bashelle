pragma ComponentBehavior: Bound
import qs.components
import Quickshell.Services.Mpris
import QtQuick
import qs.theme
import QtQuick.Layouts
import qs.utils
import qs.services
import qs.services.pipewire
import Quickshell.Services.Pipewire

ColumnLayout {
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
        text: "No media"
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
      id: playerItem
      required property MprisPlayer modelData
      property string appName: modelData.desktopEntry || modelData.identity
      implicitWidth: playersList.width
      implicitHeight: 170

      ColumnLayout {
        anchors.fill: parent
        
        SButton {
          text: playerItem.appName
          textItem.font.capitalization: Font.Capitalize
          icon.name: IconsMap.get(playerItem.appName)
          onClicked: Hypr.focus({ window: "class:"+playerItem.appName })
        }

        SRectangle {
          gradient: Gradient {
              orientation: Gradient.Vertical
              GradientStop { position: 1.0; color: Qt.alpha(Theme.colors.primary, 0.1) }
              GradientStop { position: 0.0; color: Qt.alpha(Theme.colors.surface_container, 1) }
          }
          showBorder: true
          padding: 1

          TrackArt {
            anchors.fill: parent
            player: playerItem.modelData
          }
          
          ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 16
            
            TrackInfo {
              Layout.fillWidth: true
              player: playerItem.modelData
            }
          
            TrackLength {
              Layout.fillWidth: true
              player: playerItem.modelData
            }

            TrackControls {
              Layout.fillWidth: true
              player: playerItem.modelData
            }
          }
          
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
      }

    }
  }

}

