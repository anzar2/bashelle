import qs.components
import QtQuick
import Quickshell.Services.Notifications
import qs.services
import QtQuick.Layouts
import qs.theme

Loader {
  sourceComponent: Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
  
    ColumnLayout {
      anchors.fill: parent
        
      RowLayout {
        SRadioButton {
          text: "No molestar"
          font.bold: true 
          checked: Widgets.notification.dnd 
          onClicked: Widgets.notification.toggleDnd()
          backgroundRect.color: Theme.colors.surface_container
        }
        
        Item { Layout.fillWidth: true }
        
        SButton {
          nerdIcon.text: ""
          onClicked: Notifications.clear()
        }
      }

      SRectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        visible: Notifications.count === 0

        Column {
          anchors.centerIn: parent
          SText {
            text: ""
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 32
          }
          
          SText {
            text: "Sin notificaciones"
            size: 8
          }
        }
      }

      SListView {
        Layout.fillWidth: true
        Layout.fillHeight: true

        visible: Notifications.count > 0
        model: Notifications.server.trackedNotifications
        delegate: NotificationCard { 
          required property Notification modelData
          implicitWidth: parent.width
          showBorder: true
          color: hovered ? Theme.colors.surface_container_high : Theme.colors.surface_container
          notification: modelData
        }
      }
    }

  }
}
