import QtQuick.Layouts
import qs.components
import QtQuick
import qs.utils
import qs.services
import qs.theme

RowLayout {
  id: header
  property alias tabBar: _tabBar
  
  STabBar {
    id: _tabBar
    Component.onCompleted: forceActiveFocus()
    Keys.onLeftPressed: currentIndex = Math.max(0, currentIndex - 1)
    Keys.onRightPressed: currentIndex = Math.min(count - 1, currentIndex + 1)
    
    STabButton {
      text: "Notifications"
      identifier: "notifications"
      nerdIcon.text: NerdIcons.message_text

      SRectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        implicitWidth: 6
        implicitHeight: implicitWidth
        anchors.margins: 8
        radius: 99
        color: Theme.colors.error
        scale: Notifications.count > 0 ? 1 : 0
        animated: true
      }
    }

    STabButton {
      text: "Media"
      identifier: "mpris"
      nerdIcon.text: NerdIcons.circle_play
    }

    Layout.fillWidth: true
  }
}
