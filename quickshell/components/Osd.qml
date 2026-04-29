import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config

WidgetComponent {
  id: osd
  property real value: 0
  property string label
  property string icon
  signal moved(value: real)
  
  mask: Region { item: content }
  implicitHeight: 60
  implicitWidth: 200
  color: "transparent"
  anchors.bottom: true
  margins.bottom: Config.panel.isBottom() ? 10 : 30
  WlrLayershell.layer: WlrLayer.Overlay


  openAnimation: NumberAnimation {
    target: content
    property: "y"
    from: osd.height   
    to: 0
    duration: 500
    easing.type: Easing.OutBack
  }

  hideAnimation: NumberAnimation {
    target: content
    property: "y"
    to: osd.height    
    duration: 500
    easing.type: Easing.InBack
  }
  
  SRectangle {
    id: content
    implicitHeight: parent.height
    implicitWidth: parent.width
    padding: 13
    showBorder: true
    shadowEnabled: true

    RowLayout {
      height: parent.height
      width: parent.width
      spacing: 12
      
      NerdIcon {
        text: osd.icon
        Layout.alignment: Qt.AlignVCenter
      }

      SSlider {
        value: osd.value
        onMoved: osd.moved(value)
        Layout.alignment: Qt.AlignVCenter
        Layout.fillWidth: true
      }

      SText {
        text: osd.label
        size: 9

        Layout.alignment: Qt.AlignVCenter
      }
    }
  }

}