import QtQuick
import QtQuick.Controls

import qs.Theme

Control {
  id: separator
  property bool thin: true
  
  leftInset: 6
  rightInset: 6
  topInset: 2
  bottomInset: 2
  
  background: Rectangle {
    implicitWidth: separator.thin ? 1:2
    implicitHeight: separator.thin ? 1:2
    color: Theme.colors.surface_container_high
  }
}

