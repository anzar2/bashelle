import qs.components
import qs.services
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls

ControlPage {
  hasSwitch: true 
  switchItem.checked: WlSunset.enabled
  switchItem.onClicked: WlSunset.toggle()
  implicitHeight: 300

  ColumnLayout {
    anchors.fill: parent
    
    SegmentedControl {
      currentIndex: WlSunset.config.mode
      
      SegmentedButton {
        text: "Manual"
      }
      SegmentedButton {
        text: "Scheduled"
      }
      SegmentedButton {
        text: "Always" 
      }

      Layout.fillWidth: true
    }

    SStackView {
      initialItem: manualSettings
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    SRectangle {
      Layout.fillWidth: true
      Layout.preferredHeight: 30
      showBorder: true
      padding: 8
      RowLayout {
        anchors.fill: parent

        SText {
          text: slider.from + "K"
          size: 9

          Layout.fillWidth: true
        }
        SSlider {
          id: slider
          snapMode: Slider.SnapAlways
          from: 6500
          to: 3000
          value: WlSunset.config.temp
          stepSize: 100

          Layout.fillWidth: true
        }
        SText {
          text: slider.to + "K"
          size: 9
          Layout.fillWidth: true
        }
      }
    }


    SButton {
      text: "Apply"
      nerdIcon.text: ""
      flat: false
    }
  }

  Component {
    id: manualSettings

    SRectangle {
      showBorder: true
    }
  }
  
}