import Quickshell.Wayland
import Quickshell.Services.Notifications
import qs.components
import qs.config
import qs.services
import Quickshell
import QtQuick

WidgetComponent {
  id: window
  WlrLayershell.layer: WlrLayer.Overlay
  implicitWidth: 320
  implicitHeight: 150
  color: "transparent"
  controller: Widgets.notification

  onMouseExited: Notifications.timer.restart()
  onMouseEntered: Notifications.timer.stop()

  mask: Region { item: _notification } 

  openAnimation: NumberAnimation {
    target: _notification
    property: "y"
    from: Config.notifications.isTop ? -window.height : window.height
    to: 0
    duration: 500
    easing.type: Easing.OutBack
  }  

  hideAnimation: NumberAnimation {
    id: hideAnimation
    target: _notification
    property: "y"
    to: Config.notifications.isTop ? -window.height : window.height
    duration: 250
    easing.type: Easing.InBack
  }

  anchors {
    top: Config.notifications.isTop
    bottom: Config.notifications.isBottom
    right: Config.notifications.isRight
    left: Config.notifications.isLeft
  }
  
  NotificationCard { 
    id: _notification
    property Notification lastNotification: Notifications.last
    shadowEnabled: true
    showBorder: true
    notification: lastNotification
  }
}
