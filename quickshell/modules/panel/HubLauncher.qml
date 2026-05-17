import qs.components
import qs.services
import qs.config
import qs.theme
import qs.utils
import QtQuick

SButton {
  Component { id: iconV; NerdIcon { text: NerdIcons.dots_h; size: 10 } }
  Component { id: iconH; NerdIcon { text: NerdIcons.dots_v; size: 10 } }
  
  nerdIcon: Config.panel.isVertical() ? iconV : iconH
  onClicked: Widgets.hub.toggle()
  highlighted: Widgets.hub.active

  SRectangle {
    anchors.top: parent.top
    anchors.right: parent.right
    implicitWidth: 6
    implicitHeight: implicitWidth
    anchors.margins: 4
    radius: 99
    color: Theme.colors.error
    scale: Notifications.count > 0 ? 1 : 0
    animated: true
  }
}
