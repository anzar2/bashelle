import QtQuick
import QtQuick.Layouts

import qs.Modules.Panel
import qs.Services.Time
import qs.Components.Controls
import qs.Components
import qs.Utils
import qs.Config

PanelModule {
  id: module
  roleValue: "clock"

  SButton {
    id: clock
    property string dateFormat: Config.panel.isVertical() ? Config.clock.verticalFormat : Config.clock.horizontalFormat
    flow: Config.panel.getFlow()
    showIcon: Config.clock.icon
    icon: NerdIcon { 
      text: NerdIcons.clock
      size: 10
    }
    text: Qt.formatDateTime(Time.now, dateFormat)     

    font.bold: Config.clock.bold
    textItem.horizontalAlignment: Text.AlignHCenter
    textItem.verticalAlignment:   Text.AlignVCenter
    fontSize: Config.clock.fontSize
    showBorder: true

    Layout.alignment: Qt.AlignCenter
    Layout.fillWidth: Config.panel.isVertical()
  }

}

