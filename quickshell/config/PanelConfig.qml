import Quickshell.Io
import qs.services
import QtQuick

JsonObject {
  property string position: "" // top | bottom | right | left
  property int size: 30
  
  function isVertical(): bool { return position === "left" || position === "right" }
  function isRight(): bool {  return position === "right" }
  function isLeft(): bool {  return position === "left" }
  function isTop(): bool { return position === "top" }
  function isBottom(): bool { return position === "bottom" }
  function getFlow(): int { return isVertical() ? Flow.TopToBottom : Flow.LeftToRight }

  function setPosition(p) {
    position = p
  }
}
