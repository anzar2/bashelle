// Base service object
import Quickshell
import QtQuick

Singleton {
  property bool   ready: false
  property string name: "Service"
  property int    logPad: 10
  signal start()

  onStart: log("Service started")

  function log(...args) {
    console.log(`[${name}]`.padEnd(logPad), ...args)
  }

  function error(...args) {
    console.error(`[${name}]`.padEnd(logPad), ...args)
  }
}
