import QtQuick.Controls
import QtQuick

StackView {
  id: stackview
  clip: true
  pushEnter: Transition {
    NumberAnimation { 
      property: "x"
      from: stackview.width
      to: 0
      duration: 300
      easing.type: Easing.OutCubic
    }
  }
  pushExit: Transition {
    NumberAnimation { 
      property: "x"
      from: 0
      to: -stackview.width
      duration: 300
      easing.type: Easing.OutCubic
    }
  }
  popEnter: Transition {
    NumberAnimation { 
      property: "x"
      from: -stackview.width
      to: 0
      duration: 300
      easing.type: Easing.OutCubic
    }
  }
  popExit: Transition {
    NumberAnimation { 
      property: "x"
      from: 0
      to: stackview.width
      duration: 300
      easing.type: Easing.OutCubic
    }
  }
}