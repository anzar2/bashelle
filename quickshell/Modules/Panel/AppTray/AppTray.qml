pragma ComponentBehavior: Bound

import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick

import qs.Modules.Panel
import qs.Components
import qs.Components.Controls
import qs.Config
import qs.Theme
import qs.Utils

PanelModule {
  roleValue: "apps_tray"

  SRectangle {
    id: root
    implicitWidth:  wrapper.width
    implicitHeight: wrapper.height
    animated: true
    color: Theme.colors.surface
    showBorder: true


    Layout.alignment: Qt.AlignCenter
    Layout.fillHeight: Config.panel.isHorizontal()
    Layout.fillWidth:  Config.panel.isVertical()
    
    WrapperItem {
      id: wrapper
      anchors.centerIn: parent
      
      GridLayout {
        id: grid
        property bool collapsed: false
        
        rowSpacing: 0; columnSpacing: 0;
        flow: Config.panel.getFlow()

        Repeater {
          visible: grid.collapsed
          model: SystemTray.items
          delegate: SButton {
            id: button
            required property SystemTrayItem modelData
            icon: IconImage {
              source: button.modelData.icon
              implicitSize: 12.8
              Layout.alignment: Qt.AlignCenter
            }
            visible: grid.collapsed
          }
        }

        SButton {
          icon: NerdIcon {
            text: Config.panel.isVertical() ? NerdIcons.dots_h : NerdIcons.dots_v
          }
          onClicked: grid.collapsed = !grid.collapsed
          highlighted: grid.collapsed
          Layout.fillWidth: Config.panel.isVertical()
          Layout.fillHeight: Config.panel.isHorizontal()
        }
      }
    }
  }

}
