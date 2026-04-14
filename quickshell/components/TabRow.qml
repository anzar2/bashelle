import QtQuick
import QtQuick.Layouts
import qs.theme

Item {
  id: root
  default property alias items: _tabs.data
  property var currentTab: null
  property bool showIndicator: true
  property bool fillIndicator: false
  property bool fillWidth: false

  Layout.fillWidth: fillWidth

  function setTab(index) {
    currentTab = items[index]
  }

  implicitHeight: _tabs.implicitHeight
  implicitWidth: _tabs.implicitWidth

  RowLayout {
    id: _tabs
    width: root.width
  }

  Separator {
    Layout.fillWidth: true
    y: 30
    z: -2
    visible: !root.fillIndicator
  }
  
  SRectangle {
    id: indicator
    implicitHeight: root.fillIndicator ? root.currentTab?.height : 2
    implicitWidth: root.currentTab?.width
    x: root.currentTab?.x ?? 0
    y: root.fillIndicator ? 0 : root.currentTab?.height
    color: Theme.colors.primary
    visible: root.showIndicator
    z: -1

    Behavior on x {
      NumberAnimation {
        easing.type: Easing.OutCirc
        duration: 150
      }
    }

    Behavior on implicitWidth {
      NumberAnimation {}
    }
  }
}
