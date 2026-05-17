import QtQuick.Layouts
import QtQuick
import qs.theme

SRectangle {
  id: bg
  property bool thin: true
  implicitWidth: thin ? 1:2
  implicitHeight: thin ? 1:2
  color: Theme.colors.surface_container_high
}
