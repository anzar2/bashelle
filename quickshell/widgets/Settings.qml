pragma ComponentBehavior: Bound
import qs.components
import qs.services
import QtQuick.Layouts
import QtQuick
import qs.theme
import qs.utils
import qs.types

WidgetComponent {
  id: widget
  controller: Widgets.settings
  implicitWidth: 800 / 1.1
  implicitHeight: 600 / 1.1
  focusGrab.active: true
  focusable: true
  onFocusLost:     Widgets.settings.hide()
  onEscapePressed: Widgets.settings.hide()
  color: "transparent"

  readonly property var menu: [
    { text: "Appearance", 
      icon: NerdIcons.palette 
    },
  ]
  
  SRectangle {
    id: content
    anchors.fill: parent
    showBorder: true
    shadowEnabled: true
    padding: 4
    
    RowLayout {
      anchors.fill: parent
      spacing: 2

      SRectangle {
        showBorder: true
        padding: 8
        
        SideMenu {
          id: sideMenu
          currentIndex: 0
          anchors.fill: parent
          model: widget.menu
        }

        Layout.preferredWidth: 175
        Layout.fillHeight: true
      }


      SRectangle {
        SStackView {
          
        }
        showBorder: true
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }
  }
    
  openAnimation: NumberAnimation {
    target: content
    property: "scale"
    from: 0.97; to: 1
    easing.type: Easing.OutQuad
  }

  hideAnimation: NumberAnimation {
    target: content
    property: "scale"
    to: 0.97
    easing.type: Easing.InQuad
  }
}
