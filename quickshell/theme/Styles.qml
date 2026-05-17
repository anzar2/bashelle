pragma Singleton
import Quickshell
import QtQuick
import qs.types
import qs.theme

Singleton {
  component ButtonVariants: QtObject {
    property ButtonStyle clear
    property ButtonStyle filled
    property ButtonStyle none
  }

  property ButtonVariants splitButton: ButtonVariants {
    clear: ButtonStyle {
      background: Theme.colors.surface_container_low
      foreground: Theme.colors.secondary
      foregroundHighlight: Theme.colors.secondary
      backgroundHighlight: Theme.colors.surface_container
    }
    
    filled: ButtonStyle {
      background: Theme.colors.primary
      foreground: Theme.colors.secondary
      foregroundHighlight: Theme.colors.surface
      backgroundHighlight: Theme.colors.primary
    }
  }

  property ButtonVariants button: ButtonVariants {
    clear: ButtonStyle {
      background:          "transparent"
      foreground:          Theme.colors.on_surface
      backgroundHighlight: Theme.colors.surface_container
      foregroundHighlight: Theme.colors.on_surface
    }

    filled: ButtonStyle {
      background:          Theme.colors.primary
      foreground:          Theme.colors.surface
      foregroundHighlight: Theme.colors.surface
      backgroundHighlight: Theme.colors.primary_fixed
    }

    none: ButtonStyle {
      background:          "transparent"
      foreground:          Theme.colors.surface
      foregroundHighlight: Theme.colors.surface
      backgroundHighlight: "transparent"
    }
  }
}
