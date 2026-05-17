pragma ComponentBehavior: Bound
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs.config
import qs.components
import Quickshell
import qs.theme

SRectangle {
  id: apptray

  implicitWidth: grid.width
  implicitHeight: grid.height
  visible: SystemTray.items.values.length > 0
  showBorder: true
  color: Qt.alpha(Theme.colors.surface_container, 0.5)

  GridLayout {
    id: grid
    flow: Config.panel.getFlow()
    rowSpacing: 0; columnSpacing: 0
    anchors.centerIn: parent

    Repeater {
      model: SystemTray.items
      delegate: ButtonMenu {
        id: button
        required property SystemTrayItem modelData
        icon.name: modelData.icon

        menu: SMenu {
          popupType: Popup.Window
          implicitWidth: parent.width
        }
        
        Layout.minimumWidth: 20
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }
  }

}
