pragma ComponentBehavior: Bound
import qs.components
import qs.theme
import qs.config
import qs.utils
import qs.services
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import Quickshell

SRectangle {
  id: root
  property ShellScreen monitor: NaN
  property real indicatorSize: (Config.panel.isVertical() ? implicitWidth : implicitHeight) - wsFlow.padding

  color: Qt.alpha(Theme.colors.primary, 0.05)
  // radius: Config.workspaces.radius
  showBorder: true
  implicitWidth: wsFlow.width
  implicitHeight: wsFlow.height

  Flow {
    id: wsFlow
    spacing: Config.workspaces.workspaceSpacing
    padding: 2
    flow: Config.panel.getFlow()

    Repeater {
      model: Hypr.workspaces.filter(ws => ws.monitor?.name === root.monitor.name)
      delegate: WorkspaceIndicator {
        id: indicator
        required property HyprlandWorkspace modelData
        implicitWidth: modelData.toplevels.values.length === 0 ? root.indicatorSize : topLevels.width
        implicitHeight: modelData.toplevels.values.length === 0 ? root.indicatorSize : topLevels.height
        radius: root.radius
        focused: modelData.focused || Hypr.special.enabled
        background.scale: focused || hovered || modelData.toplevels.values.length > 0 ? 1 : 0
        dot.visible: modelData.toplevels.values.length === 0
        onClicked: Hypr.focus({ workspace: modelData.id })
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
              property string iconUrl: IconsMap.get(modelData?.lastIpcObject.initialClass ?? "")

              implicitWidth: root.indicatorSize
              implicitHeight: root.indicatorSize
              icon.implicitSize: root.indicatorSize * 0.8
              icon.source:iconUrl            
              onMiddleClicked: Hypr.close(`address:0x${modelData.address}`)

              TapHandler {
                acceptedButtons: Qt.LeftButton
                onSingleTapped: {
                  Hypr.alter_zorder("top", `address:0x${toplevel.modelData.address}`)
                }
              }
            }
          }

          add: Transition {
            NumberAnimation {
              property: "scale"
              from: 0
              to: 1
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
        Hypr.focus({ workspace: "-1" });
      } else
        Hypr.focus({ workspace: "+1" });
    }
  }
}
