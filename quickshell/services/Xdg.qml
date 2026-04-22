pragma Singleton
import QtQuick
import Quickshell

QtObject {
  function setDefaultFileManager(desktopFile: string) {
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "inode/directory"])
  }

  function setDefaultBrowser(desktopFile: string) {
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "x-scheme-handler/http"])
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "x-scheme-handler/https"])
  }

  function openFileManager(path = "$HOME") {
    Quickshell.execDetached(["sh","-c", `xdg-open ${path}`])
  }
  
  function openTerminal() {
    Quickshell.execDetached(["xdg-terminal-exec"])
  }
}