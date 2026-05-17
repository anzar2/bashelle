//@ pragma UseQApplication
//@ pragma IconTheme Papirus-Dark
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.modules
import qs.config
import qs.services
import qs.widgets
import qs.widgets.audio
import qs.widgets.hub
import qs.widgets.notifications
import qs.widgets.wallpaper
import qs.modules.panel
import qs.widgets.osd
import Quickshell.Hyprland

ShellRoot {
  // What services we need to be instanced on start
  property var services: [Config, Notifications, Bt]

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

  Loader {
    sourceComponent: AudioOsd {}
    active: Widgets.audioOsd.active
  }

  Loader {
    sourceComponent: AudioSettings {}
    active: Widgets.audioSettings.active
  }

  Loader {
    sourceComponent: MicSettings {}
    active: Widgets.micSettings.active
  }

  Loader {
    sourceComponent: Settings {}
    active: Widgets.settings.active
  }

  BarManager {}
}
