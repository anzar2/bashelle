import QtQuick

ListView {
  snapMode: ListView.SnapToItem
  spacing: 10
  clip: true
  add: Transition {
    NumberAnimation {
      property: "opacity"
      from: 0
      to: 1
      duration: 300
      easing.type: Easing.OutCubic
    }
    
    NumberAnimation {
      property: "scale"
      from: 0.85
      to: 1.0
      duration: 300
      easing.type: Easing.OutBack
    }
  }

  remove: Transition {
    NumberAnimation {
      property: "opacity"
      to: 0
      duration: 250
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      property: "scale"
      to: 0.85
      duration: 250
      easing.type: Easing.InCubic
    }
  }
}
