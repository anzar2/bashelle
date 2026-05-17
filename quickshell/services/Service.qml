// Base service object
import Quickshell
import QtQuick
Singleton {
  property bool ready: false
  property string name: "Service"

  function log(message: string) {
    console.log(`[${name}]`, message)
  }

  Component.onCompleted: log("Service summoned")
}
