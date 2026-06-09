pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.Components
import qs.Theme
import qs.Components.Controls
import qs.Services.Pipewire
import qs.Config

Loader {
  id: root
  required property var modelData
  property bool inUse: Pw.sourceTracker.linkGroups.length > 0
  active: Pw.source.device && modelData.active

  visible: !modelData.reactive || inUse

  Layout.minimumWidth: 24
  Layout.alignment: Qt.AlignCenter
  Layout.fillWidth: Config.panel.isVertical()
  Layout.fillHeight: Config.panel.isHorizontal()

  sourceComponent: SButton {
    id: button
    icon: NerdIcon {
      text: Pw.source.icon
      size: 10.5
      opacity: button.textItem.opacity

      Rectangle {
        implicitWidth: 6; implicitHeight: 6;
        radius: 6
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: -2
        border.width: 1
        border.color: Theme.colors.surface
        color: Theme.colors.error
        visible: root.inUse
      }
    }
      
    padding: 5
    flow: Config.panel.getFlow()
    textItem.opacity: root.inUse ? 1 : 0.5
    text: Pw.source.volume
    textItem.visible: root.modelData.showPercentage
    fontSize: 7.7
  }
}
