import QtQuick
import QtQuick.Layouts

import qs.Components.Controllers
import qs.Services.Notifications
import qs.Components.Controls
import qs.Modules.Panel
import qs.Components
import qs.Config
import qs.Theme

PanelModule {
  roleValue: "notifications"

  SButton {
    id: button
    showBorder: true
    columnSpacing: 8
    fontSize: 8
    flow: Config.panel.getFlow()
    onClicked: Notifications.clear()
    text: Notifications.count
    textItem.visible: Config.notifications.showCount
    
    icon: NerdIcon {
      text: Notifications.icon
      size: 10.5
     
      Rectangle {
        property real size: 7
        implicitWidth: size; implicitHeight: size;
        radius: size
        anchors.top:  parent.top
        anchors.right: parent.right
        anchors.margins: -2
        color: Theme.colors.error
        scale: (Notifications.count > 0) ? 1 : 0
        border.width: 1
        border.color: Theme.colors.surface_container_lowest

        Behavior on scale { NumberAnimation { duration: 100 } }
      }
    }
    
    Layout.alignment: Qt.AlignCenter
    Layout.fillWidth: Config.panel.isVertical()
  }
}
