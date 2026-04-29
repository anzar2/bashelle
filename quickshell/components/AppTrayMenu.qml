pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland
import Quickshell

// Is the same as PopupMenu, but adapted to SystemTray menu
PopupWindow {
  id: root
  property alias focusGrab: _focusGrab
  property QsMenuOpener opener
  
  implicitWidth: 250
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
    from: 0.9
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
    scale: 0.3
    Keys.onEscapePressed: root.hide()
    clip: true

    SRectangle {
      id: background
      implicitWidth: parent.width
      implicitHeight: Math.min(stackview.implicitHeight + (padding * 2), root.implicitHeight - 8)
      padding: 4
      animated: false
      clip: true
      shadowEnabled: true

      StackView {
        id: stackview

        implicitWidth: parent.width
        implicitHeight: currentItem?.implicitHeight ?? 0
      }
    }
  }

  function calculateHeight(model) {
    let menuHeight = 46
    
    for (let entry of model) {
      menuHeight += entry.isSeparator ? 2 : 28
    }

    return menuHeight
  }

  function show(parent, type="window", opener, x, y) {
    let model = opener.children.values
    root.implicitHeight = calculateHeight(model)

    stackview.push("DBusMenu.qml", {
      opener: opener,
      stackview: stackview,
      popup: root
    })

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
    openAnimation.start()
    background.animated = true
  }

  function hide() {   
    hideAnimation.start()
  }
}