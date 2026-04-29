pragma ComponentBehavior: Bound
import Quickshell
import qs.components
import qs.services
import QtQuick
import QtQuick.Layouts
import qs.utils
import qs.config

WidgetComponent {
  id: widget
  controller: Widgets.controlCenter
  focusGrab.active: false
  focusable: true
  onFocusLost: Widgets.controlCenter.hide()
  onEscapePressed: Widgets.controlCenter.hide()

  implicitWidth: 350
  
  property real targetAnimPosition: {
      switch (Config.panel.position) {
        case "left":
          return -widget.width
        case "right":
          return widget.width
        case "top":
          return -widget.height
        case "bottom": 
          return widget.height
      }
    }
  
  anchors.right: !Config.panel.isLeft()
  anchors.left: Config.panel.isLeft()
  anchors.top:  true 
  anchors.bottom: true

  openAnimation: NumberAnimation {
    target: content
    property: Config.panel.isVertical() ? "x" : "y"
    from: widget.targetAnimPosition
    to: 0
    duration: 350
    easing.type: Easing.OutQuad
  }

  hideAnimation: NumberAnimation {
    target: content
    property: Config.panel.isVertical() ? "x" : "y"
    duration: 350
    to: widget.targetAnimPosition
    easing.type: Easing.InQuad
  }

  mask: Region {
    item: content
  }

  color: "transparent"

  Item {
    implicitWidth: parent.width
    implicitHeight: content.height
    anchors.bottom: Config.panel.isVertical() || Config.panel.isBottom() ? parent.bottom : undefined
    clip: false
    focus: true

    SRectangle {
      id: content
      implicitWidth: parent.width
      implicitHeight: stackview.height + padding * 2
      padding: 16
      animated: true
      shadowEnabled: true
      showBorder: true

      SStackView {
        id: stackview
        width: parent.width
        height: currentItem ? currentItem.implicitHeight : 0
        initialItem: mainView
        clip: true
      }
    }
  }

  Component {
    id: mainView
    
    ColumnLayout {
      spacing: 8
      implicitHeight: childrenRect.height

      GridLayout {
        id: splitButtons
        columns: 2
        rowSpacing: 8
        columnSpacing: 8

        SplitButton {
          checked: WlSunset.enabled
          primaryButton.onClicked: WlSunset.toggle()
          secondaryButton.onClicked: stackview.push("NightLightSettings.qml", {
            stackview: stackview,
            title: text
          })
          text: "Night Light"
          subtext: {
            switch (WlSunset.config.mode) {
              case WlSunset.Mode.Scheduled:
              case WlSunset.Mode.Manual:
                return `${WlSunset.sunrise} - ${WlSunset.sunset}`
              default:
                return "Always"
            }
          }

          nerdIcon: NerdIcons.night_mode
          primaryButton.nerdIcon.text: NerdIcons.night_mode
          Layout.fillWidth: true
        }

        SplitButton {
          checked: false
          text: "Bluetooth"
          subtext: "Disconnected"
          nerdIcon: NerdIcons.bluetooth
          Layout.fillWidth: true
        }
      }

      Separator {}
      
      GridLayout {
        columns: 2
        
        SliderControl {
          id: sinkControl
          button.nerdIcon.text: Audio.sink.icon
          button.onClicked: Audio.sink.toggleMute()
          slider.value: Audio.sink.rawVolume
          slider.onMoved: Audio.sink.setVolume(slider.value)

          slider.implicitHeight: 7
          configButton.onClicked: stackview.push("SinkSettings.qml", {
            stackview: stackview,
            title: "Audio Outputs",
          })
          Layout.fillWidth: true
        }
        
        SliderControl {
          id: sourceControl
          visible: true
          button.nerdIcon.text: Audio.source.icon
          button.onClicked: Audio.source.toggleMute()
          slider.value: Audio.source.rawVolume
          slider.onMoved: Audio.source.setVolume(slider.value)
          slider.enabled: Audio.source.device !== null
          slider.implicitHeight: 7
          configButton.onClicked: stackview.push("SourceSettings.qml", {
            stackview: stackview,
            title: "Audio Inputs",
          })

          Layout.fillWidth: true
        }
      }
      Item { Layout.fillHeight: true; Layout.fillWidth: true }
    }
  }
}
