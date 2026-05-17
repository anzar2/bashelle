import QtQuick

Item {
  id: accordion
  property bool expanded: false
  property Component button: null
  property Component body: null
  clip: true

  implicitWidth: parent.width
  implicitHeight: _column.implicitHeight

  function toggle() {
    expanded = !expanded;
  }

  Column {
    id: _column
    width: parent.width
    spacing: 4

    Loader {
      id: buttonLoader
      sourceComponent: accordion.button
      width: parent.width
    }
    
    Loader {
      id: bodyLoader
      property bool ready: false
      sourceComponent: accordion.body
      height: accordion.expanded ? implicitHeight : 0
      width: parent.width
      clip: true
      
      Behavior on height {
        NumberAnimation {
          easing.type: Easing.InOutQuad
          duration: 200
        }
      }
    }
  }
}
