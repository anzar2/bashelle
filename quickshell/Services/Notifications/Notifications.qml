pragma Singleton
import Quickshell.Services.Notifications
import Quickshell
import QtQuick

import qs.Services
import qs.Utils
import qs.Config

Service {
  id: service
  name: "Notifications"
  
  property Notification last: null
  property int count: _server.trackedNotifications.values.length
  property alias server: _server
  property alias dnd: props.dnd
  property alias popup: popupProps

  property string icon: {
    if (service.dnd) return NerdIcons.bell_sleep
    if (service.count == 0) return NerdIcons.bell_outline
    return NerdIcons.bell
  }
  
  function toggleDnd() { dnd = !dnd }

  function send(opts) {
    if (opts) {
      let appName = opts["appName"]   ?? "Bashelle"
      let icon    = opts["icon"]       ?? "application-x-executable"
      let summary = opts["summary"]    ?? ""
      let body    = opts["body"]       ?? ""
      let attr    = opts["attributes"] ?? "{}"
      let timeout = opts["timeout"]    ?? 0

      Quickshell.execDetached(["gdbus",
        "call", "--session",
        "--dest", "org.freedesktop.Notifications",
        "--object-path", "/org/freedesktop/Notifications",
        "--method", "org.freedesktop.Notifications.Notify",
        appName, 0,
        icon,
        summary, 
        body,
        "[]",
        attr,
        timeout
      ])

      service.log(attr)
    }
  }

  function clear() {
    if (count > 0) {
      for (let i=count-1; i >= 0; i--) {
        _server.trackedNotifications.values[i].dismiss()
      }
    }
  }

  Connections {
    target: _server

    function onNotification(n: Notification) {
      if (!props.dnd) {
        service.last = n
        n.tracked = true

        popupProps.show()        
        service.log(`${n.appName}: [${n.summary},${n.body}] actions:[${n.actions}] timeout:[${n.expireTimeout}]`)
      }
    }
  }
  
  PersistentProperties {
    id: props
    property bool dnd: false
  }

  PersistentProperties {
    id: popupProps
    property bool active: false
    property int displayTime: Config.notifications.displayTime
    signal show()
    signal hide()

    signal timeout()

    onShow: () => {
      active = true
      popupTimer.interval = (displayTime > 0) ? displayTime : service.last.expireTimeout
      startTimer()
    }

    function stopTimer() {
      if (popupTimer.interval > 0) {
        popupTimer.stop()
      }
    }

    function startTimer() {
      if (popupTimer.interval > 0) {
        popupTimer.restart()
      }
    }
  }

  Timer {
    id: popupTimer
    onTriggered: popupProps.timeout()
  }

  NotificationServer { 
    id: _server 
    imageSupported: true
    actionsSupported: true
  } 
}

