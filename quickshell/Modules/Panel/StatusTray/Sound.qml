pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.Components
import qs.Components.Controls
import qs.Config
import qs.Services.Pipewire

Loader {
  id: root
  required property var modelData  
  active: Pw.sink.device && modelData.active


  Layout.minimumWidth: 24
  Layout.alignment: Qt.AlignCenter
  Layout.fillWidth: Config.panel.isVertical()
  Layout.fillHeight: Config.panel.isHorizontal()

  sourceComponent: SButton {
    icon: NerdIcon {
      text: Pw.sink.icon
      size: 10
    }

    text: Pw.sink.volume
    textItem.visible: root.modelData.showPercentage
    fontSize: 7.25
    padding: 5
    flow: Config.panel.getFlow()
  }
}
