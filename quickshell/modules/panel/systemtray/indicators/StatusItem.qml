import qs.components
import qs.config
import QtQuick.Layouts
import qs.theme

ButtonMenu {
  id: button
  flow: Config.panel.getFlow()
  textSize: 7.8
  iconSize: 10
  onRightClicked: menu?.popup(button, 0,button.height) ?? {}
  Layout.minimumWidth: 25
  Layout.minimumHeight: 25
  Layout.fillWidth: true
  Layout.fillHeight: true
}

