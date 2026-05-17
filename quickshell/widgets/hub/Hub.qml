import qs.components
import qs.services
import QtQuick.Layouts
import QtQuick
import Quickshell
import QtQuick.Controls
import qs.config
import Quickshell.Wayland
import qs.theme
import "notifications"
import "mpris"


WidgetComponent {
  id: root
  controller: Widgets.hub
  implicitWidth: 350
  color: "transparent"
  focusGrab.active: true
  focusable: true
  onFocusLost: Widgets.hub.hide()
  onEscapePressed: Widgets.hub.hide()
  mask: Region { item: _content }

  Component { id: mprisPage; Mpris {} }
  Component { id: notificationsPage; NotificationList {} }

  openAnimation: NumberAnimation {
    id: showAnimation
    property: "x"
    target: _content
    from: Config.panel.isLeft() ? -root.width : root.width
    to: 0
    duration: 350
    easing.type: Easing.OutSine
  }
  
  hideAnimation: NumberAnimation {
    id: hideAnimation
    property: "x"
    target: _content
    to: Config.panel.isLeft() ? -root.width : root.width
    duration: 250
    easing.type: Easing.InSine
  }

  anchors {
    top: true
    right: !Config.panel.isLeft() 
    left: Config.panel.isLeft()
    bottom: true
  }

  SRectangle {
    id: _content
    animated: true
    implicitWidth: parent.width
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    shadowEnabled: true
    clip: true
    padding: 12
    focus: true

    ColumnLayout {
      id: col
      anchors.fill: parent
      spacing: 10

      HubHeader {
        id: header
        tabBar.currentIndex: Widgets.hub.lastTabIndex
        tabBar.onCurrentIndexChanged: Widgets.hub.lastTabIndex = tabBar.currentIndex
        Layout.fillWidth: true
      }

      SwipeView {
        clip: true
        currentIndex: Widgets.hub.lastTabIndex
        onCurrentIndexChanged: header.tabBar.currentIndex = currentIndex
        
        NotificationList {}
        Mpris {}

        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }
  }
}
