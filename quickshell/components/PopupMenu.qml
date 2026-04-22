pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell

PopupWindow {
  id: root
  property alias focusGrab: _focusGrab
  property var model
  
  implicitWidth: 200
  color: "transparent"
  
  mask: Region { item: stackview }

  HyprlandFocusGrab {
    id: _focusGrab
    windows: [root]
    onCleared: root.hide()
  }

  NumberAnimation {
    id: openAnimation
    target: content
    property: "scale"
    duration: 100
    from: 0.95
    to: 1
  }

  NumberAnimation {
    id: hideAnimation 
    target: content
    property: "scale"
    to: 0.98
    duration: 100
    onFinished: {
      _focusGrab.active = false
      root.visible = false
      background.animated = false
      stackview.clear()
    }
  }

  Item {
    id: content
    anchors.fill: parent
    anchors.margins: 4
    focus: true  
    Keys.onEscapePressed: root.hide()
    clip: true

    SRectangle {
      id: background
      implicitWidth: parent.width
      implicitHeight: stackview.implicitHeight + (padding * 2)
      padding: 4
      clip: true
      shadowEnabled: true

      StackView {
        id: stackview
        clip: true
        implicitWidth: parent.width
        implicitHeight: currentItem?.implicitHeight ?? 120
      }
    }
  }

  function calculateHeight(model) {
    let menuHeight = 50
    let maxChildHeight = 50
    
    for (let entry of model) {
      menuHeight += entry.isSeparator ? 2 : 28
      
      if (entry.hasChildren) {
        maxChildHeight = Math.max(maxChildHeight, calculateHeight(entry.children))
      }
    }
    
    return Math.max(menuHeight, maxChildHeight)
  }

  function show(parent, type="window", model, x, y) {
    root.model = model

    stackview.push("SMenu.qml", { model: model, stackview: stackview })
    
    root.implicitHeight = calculateHeight(model)

    if (type === "window") { 
      root.anchor.window = parent
    }

    if (type === "item") {
      root.anchor.item = parent
    }
    
    root.anchor.rect.x = x
    root.anchor.rect.y = y
    
    focusGrab.active = true
    visible = true
    background.animated = true
    openAnimation.start()
  }

  function hide() {   
    hideAnimation.start()
  }
}