import QtQuick
import qs.theme
import qs.config

Text {
  property real scaleFactor: Config.appearance.fontScale
  property real size: 11.0

  color: Theme.colors.on_surface_variant
  font.family: Config.appearance.fontFamily
  font.pointSize: scaleFactor * size
}
