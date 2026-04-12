import QtQuick
import Quickshell.Services.Notifications
import qs.services

Connections {
  target: Notifications.server

  function onNotification(notification: Notification) {
    notification.tracked = true
    notification.time = Qt.formatTime(new Date(), "hh:mm")
    Notifications.last = notification

    if (!Widgets.notification.dnd) {
      Widgets.notification.show()
    }
    Notifications.timer.restart()
  }
}

