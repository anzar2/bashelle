pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.controllers

Singleton {
  property alias notification: _notification
  property alias hub: _hub
  
  NotificationController { id: _notification }
  HubController { id: _hub }
}
