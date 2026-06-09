import Quickshell.Io
import QtQuick
import Quickshell

JsonObject {
  property string position: "top" // top | bottom | right | left
  property int size: 35
  property real radius:  0
  property real margins: 0
  property real moduleSpacing: 4
  property real backgroundOpacity: 1.0

  property var modules: JsonObject {
    property list<string> start:  ["workspaces"]
    property list<string> center: []
    property list<string> end:    ["apps_tray", "status_tray", "clock", "hub"]
  }
  

  function isVertical(): bool { return position === "left" || position === "right" }
  function isHorizontal(): bool { return position === "top" || position === "bottom" }
  function isRight(): bool {  return position === "right" }
  function isLeft(): bool {  return position === "left" }
  function isTop(): bool { return position === "top" }
  function isBottom(): bool { return position === "bottom" }
  function getFlow(): int { return isVertical() ? Flow.TopToBottom : Flow.LeftToRight }
  
  function getEdges(): int {
    if (position === "top")    return Edges.Bottom
    if (position === "bottom") return Edges.Top
    if (position === "left")   return Edges.Right
    return Edges.Left
  }
  
  function getGravity(): int {
      if (position === "top")    return Edges.Bottom
      if (position === "bottom") return Edges.Top
      if (position === "left")   return Edges.Right
      return Edges.Left
  }

  function setPosition(p) {
    if (["top", "left", "right", "bottom"].includes(p)) {
      position = p
    }
  }
}
