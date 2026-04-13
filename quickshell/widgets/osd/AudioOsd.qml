import qs.components
import qs.services
import QtQuick.Layouts
import QtQuick

WidgetComponent {
  color: "transparent"
  implicitWidth: 200
  implicitHeight: 60
  anchors.bottom: true
  
  SRectangle {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: 30 + row.anchors.margins
    anchors.margins: 0
    showBorder: true

    RowLayout {
      id: row
      anchors.fill: parent
      anchors.margins: 10
      spacing: 14
      
      SText {
        text: Audio.sink.muted ? "󰸈" : "󰕾"
      }

      SSlider {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        implicitHeight: 10
        from: 0; to: 1
        value: Audio.sink.rawVolume
        onMoved: Audio.sink.setVolume(value)
      }

      SText {
        text: Audio.sink.volume
        size: 10
      }
    }
  }
}
