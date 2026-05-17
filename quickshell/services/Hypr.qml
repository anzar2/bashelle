pragma Singleton
import qs.services
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Service {
  id: service
  name: "Hyprland"

  property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
   
  property list<HyprlandWorkspace> workspaces: special.enabled ?
    Hyprland.workspaces.values.filter(ws => ws.id < 0) :
    Hyprland.workspaces.values.filter(ws => ws.id > 0)
    
    property var special: QtObject {
    property bool enabled: false
    property string name: ""
    property string monitor: ""

    onNameChanged: name = name.replace("special:", "")
  }
  
  Process { 
    id: daemon 
    onRunningChanged: running && service.log(daemon.command.join(" "))
    stdout: StdioCollector {
      onStreamFinished: service.log(text)
    }
  }

  function close(window: string) {
    let w = window.length === 0 ? "" : `{ window = "${window}" }` 
    daemon.command = ["hyprctl", "dispatch", `hl.dsp.window.close(${w})`]
    daemon.running = true
  }

  function alter_zorder(mode: string, window: string) {
    daemon.command = ["hyprctl", "dispatch", 
    `hl.dsp.window.alter_zorder({
      mode = "${mode}",
      window = "${window}"
    })`]
    daemon.running = true
  }


  function focus(target) {
    if (target["workspace"]) {
      daemon.command = ["hyprctl", "dispatch",`hl.dsp.focus({ workspace = "${target["workspace"]}" })`]
    }

    if (target["window"]) { 
      daemon.command = ["hyprctl", "dispatch", `hl.dsp.focus({ window = "${target["window"]}" })`]
    }

    daemon.running = target != null
  }

  function reload() {
    daemon.command = ["hyprctl", "reload"]
    daemon.running = true
  }

  function dispatch(cmd: string) {
    daemon.command = ["hyprctl", "dispatch", cmd]    
    daemon.running = true
  }

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name == "activespecialv2") {
        const data = event.data.split(',')
        service.special.enabled = String(data[0]) !== "" 
        service.special.monitor = String(data[2])        
        service.special.name = String(data[1])
      }
    }
  }
}
