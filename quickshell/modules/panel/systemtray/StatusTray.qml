pragma ComponentBehavior: Bound
import QtQuick
import qs.components
import qs.types
import qs.config
import qs.services
import qs.services.pipewire
import qs.utils
import qs.theme
import QtQuick.Layouts
import "indicators"

SRectangle {
  id: systemtray
  implicitWidth: grid.width
  implicitHeight: grid.height
  
  color: Qt.alpha(Theme.colors.surface_container, 0.5)
  animated: true
  showBorder: true

  GridLayout {
    id: grid
    rowSpacing: 0
    columnSpacing: 0
    anchors.centerIn: parent
    flow: Config.panel.getFlow()
    width: Config.panel.isVertical() ? systemtray.width : undefined

    Repeater {
      model: Config.systemTray.items.onDemand

      DelegateChooser {
        role: "modelData"

        DelegateChoice { roleValue: "mic";    Mic {} }
        DelegateChoice { roleValue: "audio";  Audio {} }
        DelegateChoice { roleValue: "upower"; UPower {} }
        DelegateChoice { roleValue: "bluetooth"; Bluetooth {} }
        DelegateChoice { roleValue: "network"; Network {} }
      }
    }

    Separator {
      visible: Config.systemTray.items.onDemand.length > 0
      thin: false
      Layout.margins: 6
      Layout.fillHeight: !Config.panel.isVertical()
      Layout.fillWidth: Config.panel.isVertical()
    }
 
    Repeater {
      model: Config.systemTray.items.pinned

      DelegateChooser {
        role: "modelData"

        DelegateChoice { roleValue: "mic";    Mic {} }
        DelegateChoice { roleValue: "audio";  Audio {} }
        DelegateChoice { roleValue: "upower"; UPower {} }
        DelegateChoice { roleValue: "bluetooth"; Bluetooth {} }
        DelegateChoice { roleValue: "network"; Network {} }
      }
    }

    StatusItem {
      flow: Config.panel.getFlow()
      nerdIcon: NerdIcon { 
        text: NerdIcons.chevron_down
      }
    }
  }

}
