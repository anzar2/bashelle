import QtQuick
import Quickshell

QtObject {
  property bool isSeparator: false
  property string text
  property int checkState: Qt.Unchecked
  property int buttonType: QsMenuButtonType.None
  property bool enabled: true
  property bool hasChildren: false
  property string icon
  property list<MenuEntry> children: []
  property string nerdIcon

  signal triggered()
}