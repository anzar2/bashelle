pragma ComponentBehavior: Bound
import QtQuick.Controls
import QtQuick.Layouts
import qs.theme
import QtQuick

ComboBox {
  id: combobox

  popup: SMenu {
    padding: 4
    width: 100
    focus: true
    
    contentItem: Column { 
      Repeater { model: combobox.delegateModel } 
    }
    
    y: combobox.height + 4
  }

  indicator: Item {}

  background: SRectangle {
    showBorder: true
  }

  contentItem: SButton {
    nerdIcon: NerdIcon { text: combobox.currentValue?.icon ?? "" }  
    text: combobox.currentValue?.text ?? ""
    onClicked: combobox.popup.open()
  }

  delegate: SMenuItem {
    required property var modelData
    required property int index
    implicitWidth: parent.width
    text: modelData.text ?? ""
    nerdIcon.text: modelData.icon ?? ""
    onClicked: combobox.currentValue = modelData.data
  }
  
  HoverHandler { cursorShape: Qt.PointingHandCursor }
}
