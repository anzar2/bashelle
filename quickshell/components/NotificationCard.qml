import qs.components
import qs.services
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Services.Notifications
import qs.theme

SRectangle {
  id: card
  property Notification notification
  property bool hovered: hover.hovered
  signal clicked()
  signal closed()
  color: hovered ? Theme.colors.surface_container_low : Theme.colors.surface
  scale: tap.pressed ? 0.99 : 1
  implicitWidth: parent.width
  implicitHeight: 115
  padding: 10

  ColumnLayout {
    anchors.fill: parent
    
    RowLayout {
      id: header
      Layout.fillWidth: true
      Layout.maximumWidth: card.width - card.padding * 2
      
      SText {
        text: `${card.notification.appName} - ${card.notification.time}`
        size: 8
        font.capitalization: Font.Capitalize
        font.bold: true
        Layout.fillWidth: true
      }
      
      SButton {
        nerdIcon.text: ""
        onClicked: { 
          Widgets.notification.hide()
          card.notification.dismiss() 
          card.closed()
        }
      }
    }

    RowLayout {
      id: content
      spacing: 8

      Layout.fillWidth: true
      Layout.fillHeight: true
      
      IconImage {
        source: card.notification.image
        implicitSize: 42
        visible: card.notification.image !== ""
        Layout.alignment: Qt.AlignTop
      }

      ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true

        
        SText {
          text: card.notification.summary
          size: 9
          font.bold: true
          elide: Text.ElideRight
          Layout.maximumWidth: card.implicitWidth - card.padding * 8
        }

        SText {
          text: card.notification.body
          size: 9
          elide: Text.ElideRight
          wrapMode: Text.Wrap
          maximumLineCount: 2
          Layout.maximumWidth: card.implicitWidth - card.padding * 8
        }
      }
    }
  }

  TapHandler { 
    id: tap 
    onTapped: {
      Hyprland.dispatch("focuswindow class:" + card.notification.desktopEntry)
      Widgets.notification.hide()
      card.clicked()
      if (card.notification.actions.length > 0) {
        card.notification.actions[0].invoke()
      }
    }
  }
  HoverHandler { id: hover; cursorShape: Qt.PointingHandCursor }
}
