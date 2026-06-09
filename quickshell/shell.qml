import Quickshell
import Quickshell.Io
import QtQuick

import qs.Modules.Panel
import qs.Modules.Desktop
import qs.Widgets

import qs.Services.Bashelle
import qs.Services.Notifications
import qs.Services.Hyprland

import qs.Config

ShellRoot {
  Component.onCompleted: Bashelle.start()

  Loader {
    sourceComponent: Panel {}
    active: Config.ready
  }

  Loader {
    sourceComponent: NotificationPopup {}
    active: Config.ready && Notifications.popup.active
  }

  Loader {
    sourceComponent: Desktop {}
    active: (Config.ready && Hypr.ready) && Hypr.focusedWorkspace.toplevels.values.length === 0 && !Hypr.special.enabled
  }
}
