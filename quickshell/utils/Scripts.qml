pragma Singleton
import QtQuick
import Quickshell
import qs.config

QtObject {
  function setTheme(theme: string) {
    let cmd = `${Quickshell.env("HOME")}/.config/quickshell/scripts/theme.sh`
    
    Quickshell.execDetached([cmd, theme])
    console.log("Script request:", cmd, theme)
  }
  
  function setWallpaper(theme: string, file: string, resizeMode: string, monitor: string) {
    let cmd = `${Quickshell.env("HOME")}/.config/quickshell/scripts/wallpaper.sh`
    let execList = [cmd, theme, resizeMode, monitor,`${file}`, Config.wallpapers.fallbackColor.replace("#", "")]

    Quickshell.execDetached(execList)
    console.log("Script request:", execList.join(" "))
  }
}