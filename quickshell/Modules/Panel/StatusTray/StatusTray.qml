pragma ComponentBehavior: Bound 

import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick
import Quickshell.Services.SystemTray

import qs.Components
import qs.Components.Controls
import qs.Components.Controllers
import qs.Modules.Panel
import qs.Utils
import qs.Config
import qs.Theme

PanelModule {
  id: module
  roleValue: "status_tray"

  component IndicatorChooser: DelegateChooser {
    role: "name"

    DelegateChoice {
      roleValue: "sound"
      Sound {}
    }

    DelegateChoice {
      roleValue: "battery"
      Battery {}
    }

    DelegateChoice {
      roleValue: "mic"
      Mic {}
    }
  }

  SRectangle {
    id: bg 
    implicitWidth: wrapper.width
    implicitHeight: wrapper.height
    showBorder: true
    animated: true
    color: Theme.colors.surface

    Layout.alignment: Qt.AlignCenter

    WrapperItem { 
      id: wrapper
      margin: 1

      GridLayout {
        flow: Config.panel.getFlow()
        columnSpacing: Config.systemTray.columnSpacing; 
        rowSpacing: Config.systemTray.rowSpacing;

        SButton {
          id: popupButton
          icon: NerdIcon {
            text: NerdIcons.chevron_down
          }
          onClicked: popupController.toggle()
          
          WidgetController { id: popupController }

          Loader {
            sourceComponent: PanelWidget {}
            active: popupController.active
            onLoaded: {
              item.controller = popupController
              item.anchor.item = popupButton
              popupController.show()
            }
          }
        }

        Repeater {
          model: SystemTray.items
          delegate: SButton {
            id: button
            required property SystemTrayItem modelData
            icon: IconImage {
              source: button.modelData.icon
              implicitSize: 14
            }
            
            onClicked: console.log(modelData.id)
            padding: 5
          }
        }

        Separator {
          Layout.fillHeight: Config.panel.isHorizontal()
          Layout.fillWidth: Config.panel.isVertical()
          topInset: 7
          bottomInset: 7
          visible: false
        }
        
        Repeater {
          model: Config.systemTray.items
          delegate: IndicatorChooser {}
        }
      }
    }
  }
  
}
