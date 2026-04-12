import QtQuick
import QtQuick.Layouts
import qs.components
import qs.theme

SButton {
  id: tab
  property int index: 0
  property string identifier
  property TabRow tabRow: null
  property bool active: tabRow.currentTab.index === index

  Layout.fillWidth: tabRow.fillWidth
  textColor: tabRow.fillIndicator && active ? Theme.colors.surface : Theme.colors.on_surface
  surface.color: "transparent"
  onClicked: tabRow.currentTab = this
}
