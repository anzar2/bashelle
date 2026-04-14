pragma Singleton
import QtQuick
import Quickshell

QtObject {
  function setTheme(theme: string) {
    let cmd = `${Quickshell.env("HOME")}/.config/quickshell/scripts/theme.sh`
    
    Quickshell.execDetached([cmd, theme])
    console.log("Script request:", cmd, theme)
  }
  
  function setWallpaper(theme: string, file: string, resizeMode: string, monitors: list<ShellScreen>) {
    let cmd = `${Quickshell.env("HOME")}/.config/quickshell/scripts/wallpaper.sh`
    
    let monitorStr = monitors.map(m => m.name).join(",")
    Quickshell.execDetached([cmd, theme, resizeMode, monitorStr,`${file}`])
    console.log("Script request:", cmd, theme, resizeMode, monitorStr, file)
  }
}