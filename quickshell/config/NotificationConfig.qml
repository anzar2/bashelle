import Quickshell.Io

JsonObject {
  property bool compact: false
  property int displayTime: 4500
  property list<string> position: ["", ""]  // y,x

  property bool isTop: position[0] === "top"
  property bool isBottom: position[0] === "bottom"
  property bool isRight: position[1] === "right"
  property bool isLeft: position[1] === "left"

}
