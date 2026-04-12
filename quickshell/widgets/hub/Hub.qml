import qs.components
import qs.services
import QtQuick.Layouts
import QtQuick
import Quickshell
import qs.config
import "notifications"
import "mpris"


WidgetComponent {
  id: root
  controller: Widgets.hub
  implicitWidth: 330
  color: Qt.alpha("red", 0.0)
  focusGrab: true
  onFocusLost: Widgets.hub.hide()
  onEscapePressed: Widgets.hub.hide()

  mask: Region { item: _content }

  // openAnimation: NumberAnimation {
  //   id: showAnimation
  //   property: "x"
  //   target: _content
  //   from: Config.panel.isLeft() ? -root.width : root.width
  //   to: 0
  //   duration: 350
  //   easing.type: Easing.OutSine
  // }
  //
  // hideAnimation: NumberAnimation {
  //   id: hideAnimation
  //   property: "x"
  //   target: _content
  //   to: Config.panel.isLeft() ? -root.width : root.width
  //   duration: 250
  //   easing.type: Easing.InSine
  // }

  anchors {
    top: true
    right: !Config.panel.isLeft() 
    left: Config.panel.isLeft()
    bottom: true
  }

  SRectangle {
    id: _content
    animated: true
    implicitWidth: parent.width
    implicitHeight: Widgets.hub.expanded ? parent.height : 245
    anchors.top: Config.panel.isVertical() || Config.panel.isBottom() ? undefined : parent.top
    anchors.bottom: Config.panel.isVertical() || Config.panel.isBottom() ? parent.bottom : undefined
    shadowEnabled: true
    clip: true
    padding: 10

    ColumnLayout {
      anchors.fill: parent
      spacing: 10
      
      HubHeader {}

      SRectangle {
        id: hubWidget
        Layout.fillWidth: true
        Layout.fillHeight: true
        padding: 4
        color: "transparent"
        
        NotificationList {
          anchors.fill: parent
          active: Widgets.hub.lastTabIdentifier === "notifications"
        }

        Mpris {
          anchors.fill: parent
          active: Widgets.hub.lastTabIdentifier === "mpris"
        }
      }
    }
  }
}
