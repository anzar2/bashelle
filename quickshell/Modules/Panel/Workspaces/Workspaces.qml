pragma ComponentBehavior:  Bound
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick

import qs.Modules.Panel
import qs.Config
import qs.Components
import qs.Theme
import qs.Services.Hyprland

PanelModule {
  roleValue: "workspaces"
  
  Loader {
    active: Hypr.ready
    sourceComponent: SRectangle {
      id: module
      readonly property real effectiveIconSize: iconSize - padding
      property real iconSize: Config.workspaces.iconSize
      property real padding:  2
      property var workspaceModel: Hypr.workspaces
      
      implicitWidth: wrapper.implicitWidth
      implicitHeight: wrapper.implicitHeight
      color: Theme.colors.surface_container_low
      animated: true
      radius: Config.workspaces.radius

      ClippingWrapperRectangle {
        id: wrapper
        radius: parent.radius
        margin: module.padding
        color: "transparent"

        ListView {
          id: listview
          implicitWidth:  contentItem.childrenRect.width
          implicitHeight: contentItem.childrenRect.height
          orientation: Config.panel.isHorizontal() ? ListView.Horizontal : ListView.Vertical
          snapMode: ListView.SnapToItem
          model: module.workspaceModel
          spacing: Config.workspaces.workspaceSpacing

          currentIndex: Hypr.special.enabled ? 0 : module.workspaceModel.indexOf(Hypr.focusedWorkspace)

          delegate: WorkspaceIndicator {
            required property HyprlandWorkspace modelData
            toplevels: modelData?.toplevels.values ?? []
            iconSize:  module.effectiveIconSize
            focus:     (modelData?.id ?? 1) === Hypr.focusedWorkspace.id
            radius:    module.radius
            onClicked: Hypr.focus({ workspace: modelData.id })
          }

          highlight: Rectangle {
            Rectangle {
              anchors.fill: parent
              scale: 0.18
              radius: parent.radius
              color: Theme.colors.on_primary

              visible: Hypr.focusedWorkspace.toplevels.values.length == 0 && !Hypr.special.enabled
            }
            radius: module.radius
            color: Theme.colors.primary
          }
        }
      }
    }
  }
}
