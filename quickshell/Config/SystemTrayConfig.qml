import Quickshell.Io
import QtQuick

JsonObject {
  property real columnSpacing: 1
  property real rowSpacing: 4
  property real moduleSpacing: 4
  property real fontSize: 7.6

  property list<var> items: [
    { 
      name: "sound",   
      active: true,
      showPercentage: false 
    },
    { 
      name: "battery",
      active: true,
      showPercentage: false,
      reactive: false
    },
    { 
      name: "mic",     
      active: true,
      reactive: true,
      showPercentage: false
    },
  ]

  function updateItem(m: string, opts: var) {
    let i = items.findIndex(i => i.name === m)
    
    if (i !== -1) { Object.assign(items[i], opts) }
  }
}

