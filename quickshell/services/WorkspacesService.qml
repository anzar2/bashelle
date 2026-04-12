pragma Singleton
import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  id: root
  property var workspaces: isSpecial 
                           ? Hyprland.workspaces.values.filter(ws => ws.id < 0) 
                           : Hyprland.workspaces.values.filter(ws => ws.id > 0)
          
  property bool isSpecial: false


  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name == "activespecialv2") {
        const data = event.data.split(',')
        root.isSpecial = data[0] !== "" // special workspace id
      }
    }
  }
}
