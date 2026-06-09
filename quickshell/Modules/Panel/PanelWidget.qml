import QtQuick
import Quickshell
import Quickshell.Hyprland

import qs.Components.Controllers
import qs.Components
import qs.Config

PopupWindow {
  id: popup
  default property alias content: _content.data
  property alias itemWrapper: wrapper
  property WidgetController controller: null
  property real defaultWidth:  100
  property real defaultHeight: 100
  property real margin: 8
  
  implicitWidth:  defaultWidth  + margin * 2
  implicitHeight: defaultHeight + margin * 3

  visible: controller.active

  mask: Region { item: _content }

  HyprlandFocusGrab {
    active: true
    windows: popup
    onCleared: popup.controller.hide()
  }
  
  anchor.edges:   Config.panel.getEdges()
  anchor.gravity: Config.panel.getGravity()
  color: "transparent"
  
  NumberAnimation {
    id: openAnimation
    target: _content
    easing.type: Easing.InOutQuad
    duration: 400
  }

  NumberAnimation {
    id: hideAnimation
    target: _content

    easing.type: Easing.InQuad
    onFinished: popup.controller.active = false
  }

  Connections {
    target: popup.controller

    function onShow() {
     if (popup.controller == null) return
      switch (Config.panel.position) {
        case "top":
          openAnimation.property = "y"
          openAnimation.from = -popup.height
          openAnimation.to = 0
          openAnimation.start()
          break;


        case "bottom":
          openAnimation.property = "y"
          openAnimation.from = popup.height
          openAnimation.to = 0
          openAnimation.start()
          break;

        case "left":
          openAnimation.property = "x"
          openAnimation.from = -popup.width
          openAnimation.to = 0
          openAnimation.start()
          break;

        case "right":
          openAnimation.property = "x"
          openAnimation.from = popup.width
          openAnimation.to = 0
          openAnimation.start()
          break;
      }
    }

    function onHide() {
      if (popup.controller == null) return

      switch (Config.panel.position) {
        case "top":   
          hideAnimation.property = "y"
          hideAnimation.to = -popup.height
          hideAnimation.start()
          break;

        case "bottom":   
          hideAnimation.property = "y"
          hideAnimation.to = popup.height
          hideAnimation.start()
          break;

        case "left":   
          hideAnimation.property = "x"
          hideAnimation.to = -popup.width
          hideAnimation.start()
          break;
        
        case "right":   
          hideAnimation.property = "x"
          hideAnimation.to = popup.width
          hideAnimation.start()
          break;
      }
    }
  }

  Item {
    id: wrapper
    anchors.fill: parent
    anchors.margins: popup.margin
    
    SRectangle {
      id: _content
      focus: true
      
      Keys.onEscapePressed: popup.controller.hide()

      implicitWidth:  parent.width
      implicitHeight: parent.height
      showBorder:     true
      shadowEnabled:  true
    }
  }
}
