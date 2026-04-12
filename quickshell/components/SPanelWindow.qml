import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.theme

PanelWindow {
  id: root
  signal mouseEntered()
  signal mouseExited()
  implicitWidth: 100
  implicitHeight: 100
  color: Theme.colors.surface
  WlrLayershell.exclusionMode: WlrLayershell.Normal

  HoverHandler {
    onHoveredChanged: hovered ? root.mouseEntered() : root.mouseExited()
  }
}
