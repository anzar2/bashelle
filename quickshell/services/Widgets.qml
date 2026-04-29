pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.controllers

Singleton {
  property alias notification: _notification
  property alias hub: _hub
  property alias wallpaperSelector: _wallpaperSelector
  property alias audioOsd: _audioOsd
  property alias controlCenter: _controlCenter
  
  NotificationController { id: _notification }
  HubController { id: _hub }
  WidgetController { id: _wallpaperSelector }
  WidgetController { id: _audioOsd }
  WidgetController { id: _controlCenter }
}
