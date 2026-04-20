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
  implicitHeight: content.implicitHeight + (content.padding * 2)
  color: "white"
  
  mask: Region { item: content }

  HyprlandFocusGrab {
    id: _focusGrab
    onCleared: root.hide()
  }

  NumberAnimation {
    id: openAnimation
    target: content
    property: "scale"
    duration: 100
    from: 0.98
    to: 1
  }

  NumberAnimation {
    id: hideAnimation 
    target: content
    property: "scale"
    to: 0.98
    duration: 100
    onFinished: {
      root.visible = false
      root.focusGrab.active = false
    }
  }

  Item {
    anchors.fill: parent
    anchors.margins: 4
    focus: true  
    Keys.onEscapePressed: root.hide()

    SRectangle {
      id: content
      implicitWidth: parent.width
      implicitHeight: entryList.height + (padding * 2)
      padding: 4
      shadowEnabled: true
      showBorder: true

      Column {
        id: entryList
        width: parent.width

        Repeater {
          model: root.model
          delegate: Item {
            id: entry
            required property var modelData
            implicitWidth: parent.width
            implicitHeight: modelData.isSeparator ? 2 : 28

            SButton {
              implicitWidth: parent.width
              text: entry.modelData.text
              nerdIcon.text: entry.modelData.nerdIcon
              icon.name: entry.modelData.icon
              visible: !entry.modelData.isSeparator
              onClicked: entry.modelData.triggered()
            }
          }
        }
      }
      
    }
  }

  function show(parent, type="window", model, x, y) {
    root.model = model
    
    
    if (type === "window") { 
      root.anchor.window = parent
    }

    if (type === "item") {
      root.anchor.item = parent
    }
    
    root.anchor.rect.x = x
    root.anchor.rect.y = y
    
    visible = true
    focusGrab.active = true
    openAnimation.start()

  }

  function hide() {    
    hideAnimation.start()
  }
}