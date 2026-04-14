import qs.components
import qs.config
import Quickshell.Hyprland
import QtQuick

SPanelWindow {
  id: widget
  default property alias items: _items.data
  property list<var> grabWhitelist: [widget]
  property bool focusGrab: false
  property var controller: null
  property Animation openAnimation: null
  property Animation hideAnimation: null
  
  signal focusLost()
  signal escapePressed()
  color: "white"

  Component.onCompleted: {
    if (widget.openAnimation) {
      widget.openAnimation.start()
    }
  }

  Connections {
    enabled: widget.controller !== null
    target: widget.controller

    function onHide() {
      if (widget.hideAnimation) {
        widget.hideAnimation.start()
      } else widget.controller.active = false
    }
  }

  Connections {
    enabled: widget.hideAnimation !== null
    target: widget.hideAnimation

    function onFinished() {
      widget.controller.active = false
    }
  }

  Item {
    id: _items
    anchors.fill: parent
    anchors.margins: Config.frames.width + 16
    Keys.onEscapePressed: widget.escapePressed()
  }

  HyprlandFocusGrab {
    windows: widget.grabWhitelist
    active: widget.focusGrab
    onCleared: widget.focusLost()
  }
}
