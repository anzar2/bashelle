import Quickshell.Io

JsonObject {
  property bool compact: false
  property int displayTime: 4500
  property list<string> position: ["", ""]  // y,x
  
  function isTop(): bool    { return position[0] === "top" }
  function isBottom(): bool { return position[0] === "bottom" }
  function isRight(): bool  { return position[1] === "right" }
  function isLeft(): bool   { return position[1] === "left" }
}
