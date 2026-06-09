import Quickshell.Io

import qs.Services.Awww
import qs.Services.Matugen
import qs.Config

JsonObject {

  property int    preferredMonitorWallpaperIndex: 0
  property string theme:            "dark"
  property string accentColor:      "#ed8796"
  property string fontFamily:       "Adwaita Sans"
  property real   radius:           8
  property real   fontScale:        1
  property bool   shadows:          true

  function updateColors() {
    if (Awww.ready && Matugen.ready && Config.ready) {
      if (accentColor == "auto") {
        let monitor = preferredMonitorWallpaperIndex
        let wallpaper = Awww.wallpapers[monitor] ?? Awww.wallpapers[0]

        let image = wallpaper["displaying"]["image"]
        Matugen.image(image, theme)
        return
      }

      Matugen.color(accentColor, theme)
    }
  }

  onThemeChanged:       updateColors()
  onAccentColorChanged: updateColors()
}
