import Quickshell.Io
import QtQuick
import Quickshell

JsonObject {
  property string folder: "~/.config/wallpapers"
  property string fallbackColor: "000000"

  function folderPath() {
    return "file://" + folder.replace("~", Quickshell.env("HOME"))
  }
}