pragma Singleton
import QtQuick
import Quickshell
import qs.controllers

Singleton {
  property alias hub:               _hub
  property alias audioOsd:          _audioOsd
  property alias settings:          _settings
  property alias micSettings:       _micSettings
  property alias notification:      _notification
  property alias audioSettings:     _audioSettings
  property alias wallpaperSelector: _wallpaperSelector

  NotificationController { id: _notification }
  HubController          { id: _hub }
  WidgetController       { id: _wallpaperSelector }
  WidgetController       { id: _audioOsd }
  WidgetController       { id: _audioSettings }
  WidgetController       { id: _micSettings }
  WidgetController       { id: _settings }
}
