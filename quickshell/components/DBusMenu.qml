pragma ComponentBehavior: Bound
import QtQuick
import qs.utils
import QtQuick.Controls
import Quickshell

Column {
  id: menu
  property QsMenuOpener opener
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


  ListView {
    implicitHeight: menu.popup.implicitHeight - 45
    implicitWidth: parent.width
    model: menu.opener.children
    clip: true
    delegate: Item {
      id: entry
      required property QsMenuEntry modelData
      implicitWidth: parent.width
      implicitHeight: modelData.isSeparator ? 2 : 28

      QsMenuOpener {
        id: childOpener
        menu: entry.modelData
      }


      SButton {
        visible: !entry.modelData.isSeparator && entry.modelData.buttonType == QsMenuButtonType.None
        implicitWidth: parent.width
        icon.name: entry.modelData.icon
        text: entry.modelData.text
        enabled: entry.modelData.enabled
        hoverEnabled: entry.modelData.enabled
        onClicked: {
          if (entry.modelData.hasChildren) {
            menu.stackview.push("DBusMenu.qml", {
              opener: childOpener,
              stackview: menu.stackview,
              title: entry.modelData.text,
              popup: menu.popup
            })
            return
          }

          entry.modelData.triggered()
          menu.popup.hide()
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