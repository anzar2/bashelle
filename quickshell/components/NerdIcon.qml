import QtQuick
import qs.theme

Text {
  property int size: 11

  font.pointSize: size
  font.family: "Symbols Nerd Font"
  color: Theme.colors.on_surface

  Behavior on rotation {
    NumberAnimation {
      easing.type: Easing.OutBack
    }
  }
}
