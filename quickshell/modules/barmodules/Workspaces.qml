pragma ComponentBehavior: Bound
import qs.components
import qs.theme
import qs.config
import qs.utils
import qs.services
import Quickshell.Hyprland
import QtQuick
import Quickshell

SRectangle {
  id: root
  property ShellScreen monitor: NaN
  property real indicatorSize: (Config.panel.isVertical() ? implicitWidth : implicitHeight) - wsFlow.padding
  
  color: Qt.alpha(Theme.colors.primary, 0.05)
  radius: Config.workspaces.radius
  showBorder: true
  implicitWidth: wsFlow.width
  implicitHeight: wsFlow.height

  Flow {
    id: wsFlow
    spacing: Config.workspaces.workspaceSpacing
    padding: 2
    flow: Config.panel.getFlow()

    Repeater { 
      model: WorkspacesService.workspaces.filter(ws => ws.monitor?.name === root.monitor.name)
      delegate: WorkspaceIndicator {
        id: indicator
        required property HyprlandWorkspace modelData  
        implicitWidth: modelData.toplevels.values.length === 0 ? root.indicatorSize : topLevels.width
        implicitHeight: modelData.toplevels.values.length === 0 ? root.indicatorSize : topLevels.height
        radius: root.radius
        focused: modelData.focused || WorkspacesService.isSpecial
        background.scale: focused || hovered || modelData.toplevels.values.length > 0 ? 1 : 0
        onClicked: modelData.activate()
        dot.visible: modelData.toplevels.values.length === 0
        z: -1

        Flow {
          id: topLevels
          anchors.centerIn: parent
          flow: wsFlow.flow
          spacing: Config.workspaces.iconSpacing
      
          Repeater {
            model: indicator.modelData.toplevels
            delegate: WorkspaceToplevel {
              id: toplevel
              required property HyprlandToplevel modelData
              implicitWidth: root.indicatorSize
              implicitHeight: root.indicatorSize
              icon.implicitSize: root.indicatorSize * 0.75
              mimeData: modelData.address
              icon.source: IconsMap.get(modelData.lastIpcObject.initialClass)
              onMiddleClicked: Hyprland.dispatch(`closewindow address:0x${modelData.address}`)
            }
          }

          add: Transition { 
            NumberAnimation { 
              property: "scale"; 
              from: 0; 
              to: 1; 
              duration: 250 
              easing.type: Easing.OutBack
            } 
          }

        }
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    z: -1
    onWheel: (event) => {
      if (event.angleDelta.y > 0) {
        Hyprland.dispatch("workspace -1")
      } else Hyprland.dispatch("workspace +1")
    }
  }
}
