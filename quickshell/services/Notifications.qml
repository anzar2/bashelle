pragma Singleton
import Quickshell.Services.Notifications
import Quickshell
import QtQuick
import qs.config
import qs.services

Singleton {
  property Notification last: null
  property int count: _server.trackedNotifications.values.length
  property alias server: _server
  property alias timer: _timer

  Component.onCompleted: Logger.p("Notifications", "Service started")

  NotificationServer { 
    id: _server 
    bodySupported: true
    imageSupported: true
    actionsSupported: true
    
    onNotification: (notification) =>  {
      notification.tracked = true
      Notifications.last = notification

      if (!Widgets.notification.dnd) {
        Widgets.notification.show()
      }
      Notifications.timer.restart()

      Logger.p("Notifications", `${notification.appName}: [${notification.summary},${notification.body}]`)
    }
  }
  
  function clear() {
    if (count > 0) {
      for (let i=count- 1; i >= 0; i--) {
        _server.trackedNotifications.values[i].dismiss()
      }
    }
  }


  Timer {
    id: _timer
    interval: Config.notifications.displayTime
    onTriggered: Widgets.notification.hide()
  }

  function send(summary, body, appName="Bashelle") {
    Quickshell.execDetached(["notify-send", 
      summary, 
      body, 
      "--app-name", appName
    ])
  }
}

