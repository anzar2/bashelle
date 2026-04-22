pragma ComponentBehavior: Bound
import QtQuick
import qs.utils
import QtQuick.Controls
import Quickshell

Column {
  id: menu
  property var model
  property StackView stackview
  property var popup
  property string title

  width: parent.width
  spacing: 2

  SButton {
    implicitWidth: parent.width
    text: menu.title
    visible: menu.stackview.depth > 1
    nerdIcon.text: NerdIcons.chevron_left
    onClicked: menu.stackview.pop()
  }
  

  Column {
    width: parent.width
    spacing: 2
    Repeater {
      model: menu.model
      delegate: Item {
        id: entry
        required property var modelData
        implicitWidth: parent.width
        implicitHeight: modelData.isSeparator ? 2 : 28


        SButton {
          visible: !entry.modelData.isSeparator && entry.modelData.buttonType == QsMenuButtonType.None
          implicitWidth: parent.width
          nerdIcon.text: entry.modelData.nerdIcon
          icon.name: entry.modelData.icon
          text: entry.modelData.text
          enabled: entry.modelData.enabled
          hoverEnabled: entry.modelData.enabled
          onClicked: {
            if (entry.modelData.hasChildren) {
              menu.stackview.push("SMenu.qml", {
                model: entry.modelData.children,
                stackview: menu.stackview,
                title: entry.modelData.text
              })
              return
            }

            entry.modelData.triggered()
          }
        }

        SRadioButton {
          implicitWidth: parent.width
          text: entry.modelData.text
          visible: entry.modelData.buttonType == QsMenuButtonType.RadioButton
        }

        NerdIcon {
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.margins: 8
          size: 10
          text: NerdIcons.chevron_right
          visible: entry.modelData.hasChildren
        }
        Separator { visible: entry.modelData.isSeparator }
      }
    }
  }
}