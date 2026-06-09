import Quickshell.Io
import QtQuick
import Quickshell

JsonObject {
  property string folder:           "~/.config/wallpapers"
  property string transitionType:   "random"
  property real transitionStep:     90.0
  property real transitionDuration: 1.0
  property real transitionFps:      60.0

  function folderPath() {
    return "file://" + folder.replace("~", Quickshell.env("HOME"))
  }
}
