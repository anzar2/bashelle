pragma Singleton
import QtQuick
import Quickshell 

QtObject {
  // This map contains (initialClass => correct_icon_name)
  // Some apps, (like below) doesnt match its icon name with it initialClass
  // That means some icons wont show properly on workspaces
  // This map tries to fix this problem
  
  readonly property var iconsMap: [
  [/^zen$/, "zen-browser"],
  [/^vivaldi-stable$/, "vivaldi"],
  [/^org\.qbittorrent\.qBittorrent$/, "qbittorrent"],
  [/^code-oss$/, "com.visualstudio.code.oss"],
  [/^GitHub Desktop$/, "github-desktop"],
  [/^Minecraft.*/, "minecraft"],
  [/^steam_app_(\d+)$/, "steam_icon_$1"],
  [/^Slay the Spire$/, "steam_icon_646570"],
  [/^jetbrains-idea$/, "jetbrains-idea-pj"],
  [/^ONLYOFFICE$/, "onlyoffice-desktopeditors"],
  [/^VirtualBox Manager$/, "virtualbox"]
]

function get(className) {
  let defaultClassName = Quickshell.iconPath(className ?? "", true)

  if (Quickshell.iconPath(className, true) !== "") {
    return defaultClassName
  }

  defaultClassName = Quickshell.iconPath(className.toLowerCase(), true) 
  if (defaultClassName !== "") {
    return defaultClassName
  }

  const match = iconsMap.find(([regex]) => regex.test(className))
  if (match) {
    const iconName = className.replace(match[0], match[1])
    return Quickshell.iconPath(iconName, true)
  }

  return Quickshell.iconPath("application-x-executable")

  }
}
