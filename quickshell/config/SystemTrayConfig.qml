import Quickshell.Io
import QtQuick

JsonObject {
  property var appBlackList: []
  
  property var items: JsonObject {
    property var pinned: ["audio", "upower", "network"]
    property var onDemand: ["mic", "bluetooth"]
  }
}

