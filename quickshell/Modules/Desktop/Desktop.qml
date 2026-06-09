import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls

Variants {
  id: root
  model: Quickshell.screens
  delegate: PanelWindow {

    required property ShellScreen modelData
    WlrLayershell.layer: WlrLayer.Bottom

    anchors { top: true; left: true; right: true; bottom: true}
    color: "transparent"

    Item {
      anchors.fill: parent
      ContextMenu.menu: DesktopMenu {}   
    }
  }
}
