import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

PopupWindow {
  id: root
  default property alias items: column.data
  property bool focus: false
  
  implicitHeight: content.height + 16
  color: "transparent"
  visible: false

  HyprlandFocusGrab {
    id: focusGrab
    windows: [root]
    active: false
    onCleared: root.hide()

    onActiveChanged: console.log(active)
  }

  function toggle() {
    visible ? hide() : show()
  }

  function show() {
    visible = true
    if (root.focus) {
      focusGrab.active = true
    }
  }

  function hide() {
    hideAnimation.start()
  }

  onVisibleChanged: {
    if (visible) {
      openAnimation.start()
    }
  }

  NumberAnimation {
    id: openAnimation
    target: content
    property: "scale"
    from: 0.9
    to: 1
    duration: 100
  }
  
  NumberAnimation {
    id: hideAnimation
    target: content
    property: "scale"
    to: 0.9
    duration: 100
    onFinished: {
      focusGrab.active = false
      root.visible = false
    }
  }

  Item {
    anchors.fill: parent
    anchors.margins: 8

    SRectangle {
      id: content
      showBorder: true
      focus: true
      shadowEnabled: true
      implicitHeight: (column.height + padding * 2)
      implicitWidth: parent.width
      scale: 1
      padding: 4

      ColumnLayout {
        implicitWidth: parent.width
        id: column
      }
    }
  }

}