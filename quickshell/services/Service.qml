// Base service object
import Quickshell
import QtQuick

Singleton {
  property bool ready: false
  property string name: "Service"
  signal start()

  function log(...args) {
    console.log(`[${name}]`, ...args)
  }

  function error(...args) {
    console.error(`[${name}]`, ...args)
  }

  Component.onCompleted: { 
    log("Service summoned") 
    start()
  }
}
