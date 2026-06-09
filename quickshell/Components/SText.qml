import QtQuick
import qs.Theme
import qs.Config

Text {
  property real scaleFactor: Config.appearance.fontScale
  property real size: 9.0

  color: Theme.colors.on_surface_variant
  font.family: Config.appearance.fontFamily
  font.pointSize: scaleFactor * size
}
