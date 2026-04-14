import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Popup {
  id: root
  default property alias items: column.data
  
  implicitHeight: content.implicitHeight
  visible: false

  closePolicy: Popup.NoAutoClose
  Overlay.onPressed: hide()

  function toggle() {
    visible ? hide() : show()
  }

  function show() {
    visible = true
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
      root.visible = false
    }
  }

  background: SRectangle {
    id: content
    showBorder: true
    focus: true
    shadowEnabled: true
    implicitHeight: (column.height + padding * 2)
    padding: 4

    ColumnLayout {
      width: parent.width
      id: column
    }
  }

}