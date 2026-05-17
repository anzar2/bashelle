import qs.utils
import QtQuick
import qs.theme

NerdIcon {
  id: spinner
  property bool active: false
  property real rotationSpeed: 400
  
  text: NerdIcons.spinner

  ParallelAnimation {
    running: spinner.active
    
    SequentialAnimation {
      loops: Animation.Infinite
      
      NumberAnimation {
        target: spinner
        property: "scale"
        to: 0.5
        from: 1
        duration: 1500

      }

      NumberAnimation {
        target: spinner
        property: "scale"
        to: 1
        duration: 1500
      }
    }

    NumberAnimation {
      target: spinner
      property: "rotation"
      loops: Animation.Infinite
      to: 360
      duration: spinner.rotationSpeed
    }
  }
}
