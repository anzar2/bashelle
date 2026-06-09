pragma Singleton
import Quickshell
import QtQuick

import qs.Config
import qs.Theme
import qs.Types

Singleton {
  property ButtonVariants button: ButtonVariants {
    surface: ButtonStyle {
      background:          Theme.colors.surface
      foreground:          Theme.colors.on_surface_variant
      foregroundHighlight: Theme.colors.on_surface_variant
      backgroundHighlight: Theme.colors.surface_container
    }

    surface_container: ButtonStyle {
      background:          Theme.colors.surface_container
      foreground:          Theme.colors.on_surface_variant
      foregroundHighlight: Theme.colors.on_surface_variant
      backgroundHighlight: Theme.colors.surface_container_high
    }


    surface_container_lowest: ButtonStyle {
      background:          Theme.colors.surface_container_lowest
      foreground:          Theme.colors.on_surface_variant
      foregroundHighlight: Theme.colors.on_surface_variant
      backgroundHighlight: Theme.colors.surface
    }

    primary: ButtonStyle {
      background:          Theme.colors.primary
      foreground:          Theme.colors.on_primary
      foregroundHighlight: Theme.colors.on_primary
      backgroundHighlight: Theme.colors.primary
    }


    secondary: ButtonStyle {
      background:          Theme.colors.secondary
      foreground:          Theme.colors.on_secondary
      foregroundHighlight: Theme.colors.on_secondary
      backgroundHighlight: Theme.colors.secondary
    }

    tertiary: ButtonStyle {
      background:          Theme.colors.tertiary
      foreground:          Theme.colors.on_tertiary
      foregroundHighlight: Theme.colors.on_tertiary
      backgroundHighlight: Theme.colors.tertiary
    }

    none: ButtonStyle {
      background:          "transparent"
      foreground:          Theme.colors.on_surface
      foregroundHighlight: Theme.colors.on_surface
      backgroundHighlight: "transparent"
    }
  }
}
