pragma Singleton
import QtQuick
import Quickshell
import qs.Services

Service {
  id: service
  name: "Xdg"

  property var paths: QtObject {
    property string home: Quickshell.env("HOME")
    property string state: Quickshell.env("XDG_STATE_HOME") || `${home}/.local/state`
  }

  property string currentDesktop: Quickshell.env("XDG_CURRENT_DESKTOP")
  property string sessionType:    Quickshell.env("XDG_SESSION_TYPE")

  function setDefaultFileManager(desktopFile: string) {
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "inode/directory"])
    service.log("Xdg", `Default file manager changed to: ${desktopFile}`)
  }

  function setDefaultBrowser(desktopFile: string) {
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "text/html"])
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "x-scheme-handler/https"])
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "x-scheme-handler/https"])
    service.log("Xdg", `Default browser changed to: ${desktopFile}`)
  }

  function open(path = paths.home) {
    Quickshell.execDetached(["sh","-c", `xdg-open ${path}`])
    service.log("Xdg", `Open: ${path}`)
  }
  
  function openTerminal() {
    Quickshell.execDetached(["xdg-terminal-exec"])
    service.log("Xdg", `Terminal exec`)
  }
}
