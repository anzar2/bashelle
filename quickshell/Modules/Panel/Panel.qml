import QtQuick.Layouts
import Quickshell
import QtQuick
import QtQml.Models
import Quickshell.Wayland

import qs.Modules.Panel.StatusTray
import qs.Modules.Panel.Workspaces
import qs.Modules.Panel.AppTray
import qs.Modules.Panel.Clock
import qs.Modules.Panel.Notifications
import qs.Modules.Panel.Separator
import qs.Components
import qs.Config
import qs.Theme

Variants {
  id: bar

  component ModuleChooser: DelegateChooser {
    id: chooser
    property string position

    role: "modelData"
    
    StatusTray { position: chooser.position }
    Clock { position:  chooser.position }
    AppTray { position: chooser.position }
    Workspaces { position: chooser.position }
    Separator  { position: chooser.position }
    NotificationIndicator { position: chooser.position }
  }

  model: Quickshell.screens

  delegate: PanelWindow {
    required property ShellScreen modelData
    
    screen: modelData

    anchors: {
      switch (Config.panel.position) {
        case "top":     return ({ top:  true, left:   true, right: true })
        case "bottom":  return ({ left: true, bottom: true, right: true })
        case "left":    return ({ top:  true, bottom: true, left: true })
        case "right":   return ({ top:  true, bottom: true, right: true })
        // top panel if string is empty
        default:        return ({ top:  true, left:   true, right: true })
      }
    }

    WlrLayershell.namespace: "bs:panel"
    
    implicitHeight: Config.panel.size + background.anchors.margins * 2
    implicitWidth:  Config.panel.size + background.anchors.margins * 2
    color: "transparent"

    // to prevent some ugly stuff. Nobody would wanna see it. So ugly.
    onAnchorsChanged: {
      visible = false
      panelLoader.active = false

      Qt.callLater(() => { 
        visible = true
        panelLoader.active = true
      })
    }
    
    // horizontal panel modules
    Component {
      id: hModules
      
      Item {
        anchors.fill: parent

        RowLayout {
          id: start
          property string position: "start"
          spacing: Config.panel.moduleSpacing
          
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 16

          Repeater {
            model: Config.panel.modules[start.position]
            ModuleChooser { position: start.position }
          }
        }


        RowLayout {
          id: center
          property string position: "center"
          spacing: Config.panel.moduleSpacing
          
          anchors.centerIn: parent

          Repeater {
            model: Config.panel.modules[center.position]
            ModuleChooser { position: center.position }
          }
        }


        RowLayout {
          id: end
          property string position: "end"
          spacing: Config.panel.moduleSpacing

          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.rightMargin: 16

          Repeater {
            model: Config.panel.modules[end.position]
            ModuleChooser { position:  end.position }
          }
        }
      }
    }
    
    // vertical panel modules
    Component {
      id: vModules
    

      Item {
        anchors.fill: parent

        ColumnLayout {
          id: start
          property string position: "start"
          spacing: Config.panel.moduleSpacing


          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
          anchors.topMargin: 16

          Repeater {
            model: Config.panel.modules[start.position]
            ModuleChooser { position: start.position }
          }
        }


        ColumnLayout {
          id: center
          property string position: "center"
          spacing: Config.panel.moduleSpacing
          
          anchors.centerIn: parent

          Repeater {
            model: Config.panel.modules[center.position]
            ModuleChooser { position:  center.position } 
          }
        }

        ColumnLayout {
          id: end
          property string position: "end"
          spacing: Config.panel.moduleSpacing

          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom
          anchors.bottomMargin: 16

          Repeater {
            model: Config.panel.modules[end.position]
            ModuleChooser { position:  end.position }
          }
        }
      }
    }


    SRectangle {
      id: background
      radius: Config.panel.radius
      backgroundOpacity: Config.panel.backgroundOpacity
      anchors.margins:   Config.panel.margins
      shadowEnabled: true
      anchors.fill: parent

      Loader {
        id: panelLoader
        anchors.fill: parent
        sourceComponent: Config.panel.isHorizontal() ? hModules : vModules
      }
    }
  }
}
