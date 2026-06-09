pragma ComponentBehavior: Bound
import Quickshell.Services.Notifications
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick


import qs.Services.Hyprland
import qs.Components.Controls
import qs.Components
import qs.Utils
import qs.Theme

SRectangle {
  id: card
  property alias hoverHandler: _hoverHandler
  property int bodyLineCount: 3
  
  required property Notification notification
  property bool hovered: hoverHandler.hovered
  property string appIcon: IconsMap.get(notification.appIcon)
  property real defaultHeight: Math.min(wrapper.height, 170)
  property bool expanded: false
  signal mouseEntered()
  signal mouseExited()
  signal clicked()

  TapHandler   { onTapped: card.clicked() }
  
  HoverHandler { 
    id: _hoverHandler
    onHoveredChanged: {
      if (hovered) {
        card.mouseEntered()
      } else card.mouseExited()
    }  
  }

  SToolTip {
    visible: card.hovered
    text: card.notification.body
    delay: 1500
  }

  onClicked: {
    if (notification.actions.length == 1) {
      Hypr.focus({ window: "class:"+card.notification.desktopEntry })
      notification.actions[0].invoke()
    } else notification.dismiss()
  }

  implicitWidth: parent.width
  implicitHeight: defaultHeight
  showBorder: true
  animated: true
  color: Theme.colors.surface

  WrapperItem {
    id: wrapper
    implicitWidth: parent.width
    margin: 8

    ColumnLayout {
      implicitWidth: parent.width

      RowLayout {
        id: header
        width: parent.width

        SButton {
          icon: IconImage {
            source: card.appIcon
            implicitSize: 16
          }
          text: card.notification.appName
          font.capitalization: Font.Capitalize
          enabled: false
          opacity: 1
          style: Styles.button.none
        }

        Item { Layout.fillWidth: true }

        SButton {
          icon: NerdIcon {
            text: NerdIcons.close
            size: 12
          }
          onClicked: card.notification.dismiss()
        }
      }

      RowLayout {
        id: body
        width: parent.width
        
        IconImage {
          source: card.notification.image || card.appIcon
          implicitSize: 42
          Layout.alignment: Qt.AlignTop
        }

        ColumnLayout {
          SText {
            text: card.notification.summary
            font.bold: true
            Layout.fillWidth: true
          }

          SText {
            id: bodyContent
            text: card.notification.body
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
            maximumLineCount: card.bodyLineCount
            Layout.fillWidth: true
          }

          Layout.fillHeight: true
          Layout.fillWidth: true
        }
      }

      RowLayout {
        id: actions
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignBottom
        Layout.topMargin: 6
        
        Repeater {
          model: card.notification.actions
          
          SButton {
            required property NotificationAction modelData
            style: Styles.button.surface_container
            text: modelData?.text
            onClicked: {
              modelData.invoke()
              Hypr.focus({ window: "class:"+card.notification.desktopEntry })
            }
            showBorder: true
            Layout.fillWidth: true
          }
        }
      }
    }
  }
}
