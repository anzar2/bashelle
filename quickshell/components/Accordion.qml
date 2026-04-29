import QtQuick

Item {
  id: accordion
  property bool expanded
  property Component header: null
  property Component body: null

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
      sourceComponent: accordion.header
      width: parent.width
    }
    Loader {
      sourceComponent: accordion.body
      height: accordion.expanded ? implicitHeight : 0
      width: parent.width
      Behavior on height {
        NumberAnimation {
          easing.type: Easing.OutQuart
        }
      }
    }
  }
}
