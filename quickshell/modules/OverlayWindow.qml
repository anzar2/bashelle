import Quickshell.Wayland
import Quickshell
import QtQuick
import qs.components
import qs.services

PanelWindow {
  id: overlay
  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.exclusionMode: WlrLayershell.Ignore

  mask: Region {  item: contextMenu }
  color: Qt.alpha("black", 0)
  
  anchors { 
    top: true
    left: true
    bottom: true
    right: true
  }

  Connections {
    target: Overlay

    function onShowContextMenu(model, x, y) {
      contextMenu.model = model
      contextMenu.x = x
      contextMenu.y = y
      contextMenu.visible = true   
    }
  }

  ContextMenu {
    id: contextMenu

    onModelChanged: visible = false
  }
}