pragma ComponentBehavior: Bound
import qs.components
import qs.theme
import qs.config
import qs.utils
import QtQuick.Layouts
import qs.services
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import Quickshell

SRectangle {
  id: root
  property ShellScreen monitor: NaN
  property real indicatorSize: (Config.panel.isVertical() ? implicitWidth : implicitHeight) - padding * 2
  
  clip: true   
  padding: 0
  color: Theme.colors.surface_container_low
  showBorder: true
  implicitWidth: list.contentWidth + padding * 2
  implicitHeight: list.contentHeight + padding * 2

  ListView {
    id: list
    model: Hypr.workspaces
    spacing: Config.workspaces.workspaceSpacing
    currentIndex: Hypr.workspaces.indexOf(Hypr.focusedWorkspace)
    width: Config.panel.isVertical() ?  parent.width  :  contentWidth
    height: Config.panel.isVertical() ? contentHeight :  parent.height
    orientation: Config.panel.isVertical() ? ListView.Vertical : ListView.Horizontal
    delegate: WorkspaceIndicator {
      required property HyprlandWorkspace modelData
      toplevels: modelData?.toplevels
      focused: modelData?.id === Hypr.focusedWorkspace?.id
      isSpecial: Hypr.special.enabled
      onClicked: Hypr.focus({ workspace: modelData.id })
      width:  isEmpty || Config.panel.isVertical() ? root.indicatorSize : grid.width + list.spacing
      height: isEmpty || !Config.panel.isVertical() ? root.indicatorSize : grid.height + list.spacing
    }

    highlight: Rectangle {
      color: Theme.colors.primary
      radius: Config.appearance.radius
      width: list.currentItem?.width  ?? 0
      height: list.currentItem?.height ?? 0
      x: list.currentItem?.x ?? 0
      y: list.currentItem?.y ?? 0
      
      Behavior on width {
        NumberAnimation { duration: 150; easing.type: Easing.OutSine }
      }

      Behavior on height {
        NumberAnimation { duration: 150; easing.type: Easing.OutSine }
      }

      Behavior on y {
        SpringAnimation {
          spring: 8
          damping: 0.5
        }
      }

      Behavior on x {
        SpringAnimation {
          spring: 8
          damping: 0.5
        }
      }
    }

    highlightFollowsCurrentItem: false
  }
}
