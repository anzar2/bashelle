//@ pragma UseQApplication
//@ pragma IconTheme Papirus-Dark
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.modules
import qs.config
import qs.services
import qs.widgets.hub
import qs.widgets.notifications
import qs.widgets.wallpaper
import Quickshell.Hyprland

ShellRoot {
  Variants {
    model: Quickshell.screens

    Loader {
      id: framesLoader
      required property ShellScreen modelData
      sourceComponent: Frames {
        screen: framesLoader.modelData
      }
      active: Config.frames.enabled
    }
  }

  Loader {
    sourceComponent: NotificationToast {}
    active: Widgets.notification.active
  }

  Loader {
    sourceComponent: WallpaperSelector {}
    active: Widgets.wallpaperSelector.active
  }

  Loader {
    sourceComponent: Hub {}
    active: Widgets.hub.active
  }

  Loader {
    sourceComponent: Desktop {}
    active: Hyprland.focusedWorkspace.toplevels.values.length === 0
  }

  BarManager {}
  NotificationListener {}
}
