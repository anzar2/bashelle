import Quickshell
import QtQuick
import Quickshell.Wayland

import qs.Theme
import qs.Services.Bashelle

Variants {
  model: Quickshell.screens
  delegate: PanelWindow {
    required property ShellScreen modelData
    
    screen: modelData
    color: Qt.alpha(Theme.colors.surface_container_lowest, Bashelle.overlay.opacity)

    WlrLayershell.namespace: "bs:overlay"
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    Item {
      anchors.fill: parent
      focus: true
      Keys.onEscapePressed: Bashelle.overlay.toggle()
      
      TapHandler { onSingleTapped: Bashelle.overlay.toggle() }
    }
    anchors { top: true; left: true; right: true; bottom: true }
  }
}
