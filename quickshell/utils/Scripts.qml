pragma Singleton
import QtQuick
import Quickshell

QtObject {
  function setTheme(theme: string) {
    let cmd = `${Quickshell.env("HOME")}/.config/quickshell/scripts/theme.sh`
    
    Quickshell.execDetached([cmd, theme])
    console.log("Script request:", cmd, theme)
  }
  
  function setWallpaper(theme: string, file: string) {
    let cmd = `${Quickshell.env("HOME")}/.config/quickshell/scripts/wallpaper.sh`
    
    Quickshell.execDetached([cmd, theme, `${file}`])
    console.log("Script request:", cmd, theme,file)
  }
}