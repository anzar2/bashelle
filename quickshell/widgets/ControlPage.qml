import qs.components
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import qs.utils

SRectangle {
  id: page
  property StackView stackview
  property string title: "Back"
  property bool hasSwitch: false
  property alias switchItem: _switch
  color: "transparent"

  implicitHeight: 200

  default property alias body: _items.data

  ColumnLayout {
    width: parent.width
    height: parent.height

    RowLayout {
      SButton {
        text: page.title
        nerdIcon.text: NerdIcons.chevron_left
        onClicked: page.stackview.pop()
      }
      
      Item { Layout.fillWidth: true }
      SSwitch {
        id: _switch
        visible: page.hasSwitch
      }
    }
    
    Separator {}

    Item {
      id: _items
      Layout.fillHeight: true
      Layout.fillWidth: true
    }
  }


}
