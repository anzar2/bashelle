pragma Singleton
import QtQuick
import Quickshell
import qs.services

QtObject {
  property var paths: QtObject {
    property string home: Quickshell.env("HOME")
    property string state: Quickshell.env("XDG_STATE_HOME") || `${home}/.local/state`
  }

  property string currentDesktop: Quickshell.env("XDG_CURRENT_DESKTOP")
  property string sessionType: Quickshell.env("XDG_SESSION_TYPE")

  function setDefaultFileManager(desktopFile: string) {
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "inode/directory"])
    Logger.p("Xdg", `Default file manager changed to: ${desktopFile}`)
  }

  function setDefaultBrowser(desktopFile: string) {
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "x-scheme-handler/http"])
    Quickshell.execDetached(["xdg-mime", "default", desktopFile, "x-scheme-handler/https"])
    Logger.p("Xdg", `Default browser changed to: ${desktopFile}`)
  }

  function open(path = paths.home) {
    Quickshell.execDetached(["sh","-c", `xdg-open ${path}`])
    Logger.p("Xdg", `Open: ${path}`)
  }
  
  function openTerminal() {
    Quickshell.execDetached(["xdg-terminal-exec"])
    Logger.p("Xdg", `Terminal exec`)
  }
}