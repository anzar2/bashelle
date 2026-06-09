import QtQuick
import qs.Theme

Text {
  property real size: 9
  font.pointSize: size
  font.family: "Symbols Nerd Font"
  color: Theme.colors.on_surface_variant

  horizontalAlignment: Text.AlignHCenter
  verticalAlignment:   Text.AlignVCenter
  
  Behavior on rotation {
    NumberAnimation {
      easing.type: Easing.OutBack
    }
  }
}
