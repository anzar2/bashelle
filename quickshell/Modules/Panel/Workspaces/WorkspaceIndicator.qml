pragma ComponentBehavior: Bound
import QtQuick.Controls
import QtQuick
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.Utils
import qs.Theme
import qs.Config

Control {
  id: indicator
  readonly property int toplevelsCount: toplevels.length
  property var toplevels
  property real radius: 16
  property real iconSize: 24
  signal clicked()

  TapHandler { onTapped: indicator.clicked() }
  HoverHandler { cursorShape: Qt.PointingHandCursor }
  
  implicitWidth:  Math.max(iconSize, contentItem.implicitWidth)
  implicitHeight: Math.max(iconSize, contentItem.implicitHeight)

  contentItem: ListView {
    implicitWidth:  contentItem.childrenRect.width
    implicitHeight: contentItem.childrenRect.height
    model: indicator.toplevels
    spacing: Config.workspaces.iconSpacing
    interactive: false
    orientation: Config.panel.isHorizontal() ? ListView.Horizontal : ListView.Vertical
    
    delegate: IconImage {
      required property HyprlandToplevel modelData
      source: IconsMap.get(modelData?.lastIpcObject.initialClass ?? "")
      width:  indicator.iconSize
      height: indicator.iconSize
      implicitSize: indicator.iconSize
      scale: 0.8
      antialiasing: false
      Component.onCompleted: Hyprland.refreshToplevels()
    }
  }


  background: Item {
    anchors.fill: parent
      
    Rectangle {
      id: bg
      anchors.fill: parent

      radius: indicator.radius
      scale: (indicator.hovered || indicator.toplevelsCount > 0) ? 1 : 0
      color: Theme.colors.surface_container_highest
      visible: !indicator.focus

      Behavior on scale {
        NumberAnimation {
          duration: 150
        }
      }
    }

    Rectangle {
      id: dot
      anchors.fill: parent
      scale:  0.18
      radius: indicator.radius
      color:  Theme.colors.primary
      opacity: indicator.toplevelsCount == 0 && !indicator.focus ? 1 : 0


      Behavior on scale {
        NumberAnimation {
          duration: 150
        }
      }
      Behavior on opacity {
        NumberAnimation {
          duration: 100
        }
      }
    }
  }
}
