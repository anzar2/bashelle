pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Services.Notifications


import qs.Services.Notifications
import qs.Components.Commons
import qs.Config

PanelWindow {
  id: widget
  property string position: Config.notifications.position

  implicitWidth: 330 + (wrapper.anchors.margins * 2)
  implicitHeight: Math.min(145, card.height + 8)

  mask: Region { item: card }
  exclusionMode: ExclusionMode.Normal
  color: "transparent"

  anchors {
    top:    position.includes("top")
    left:   position.includes("left")
    right:  position.includes("right")
    bottom: position.includes("bottom")
  }


  Connections {
    target: Notifications.last
    
    function onClosed(reason) {
      // prevents closing the popup on notifications replacing itself
      if (reason === NotificationCloseReason.Dismissed) {
        hideAnimation.start()
      }
    }
  }

  Connections {
    target: Notifications.popup

    function onHide() {
      hideAnimation.start()
    }

    function onTimeout() {
      Notifications.popup.hide()
    }
  }

  SpringAnimation {
    id: openAnimation
    target: card
    property: "y"
    from: widget.position.includes("top") ? -wrapper.height : wrapper.height
    to: 0
    spring: 4; damping: 0.4;
  }

  SpringAnimation {
    id: hideAnimation
    target: card
    property: "y"
    to: widget.position.includes("top") ? -wrapper.height - 16 : wrapper.height - 16
    spring: 4; damping: 0.4;
    onFinished: Notifications.popup.active = false
  }

  Component.onCompleted: openAnimation.start()

  Item {
    id: wrapper
    anchors.fill: parent
    anchors.margins: 4

    NotificationCard {
      id: card
      showBorder: true;
      animated: false
      shadowEnabled: true;
      bodyLineCount: 2
      hoverHandler.cursorShape: Qt.PointingHandCursor
      notification: Notifications.last
      onMouseEntered: Notifications.popup.stopTimer()
      onMouseExited:  Notifications.popup.startTimer()
    }
  }
}
