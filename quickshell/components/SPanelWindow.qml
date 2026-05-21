import Quickshell
import QtQuick
import qs.theme

PanelWindow {
  id: root
  signal mouseEntered()
  signal mouseExited()
  implicitWidth: 100
  implicitHeight: 100
  color: Theme.colors.surface
  exclusionMode: ExclusionMode.Normal

  HoverHandler {
    onHoveredChanged: hovered ? root.mouseEntered() : root.mouseExited()
  }
}
