pragma ComponentBehavior: Bound
import QtQuick
import qs.utils
import QtQuick.Layouts
import qs.theme
import qs.types
import Quickshell.Widgets

SRectangle {
  id: splitbutton
  property bool checked: false
  property ButtonStyle style: checked ? 
    Styles.splitButton.filled : 
    Styles.splitButton.clear
  
  property string text
  property string subtext
  property string nerdIcon
  property real iconSize: 12
  property alias primaryButton: _primaryButton
  property alias secondaryButton: _secondaryButton

  implicitHeight: row.height + padding * 2
  showBorder: true
  border.color: Theme.colors.surface_container_high
  color: Theme.colors.surface_container_high
  padding: 1

  RowLayout {
    id: row
    spacing: 1
    width: parent.width
    
    SButton {
      id: _primaryButton
      style: splitbutton.style
        
      surface.topRightRadius: 0
      surface.bottomRightRadius: 0
      surface.animated: true
      highlighted: splitbutton.checked

      text: "Button"
      Layout.fillWidth: true
      
      contentItem: Row {
        spacing: 8

        IconImage {
          source: _primaryButton.icon.source
          visible: _primaryButton.icon.source.toString() !== ""
          implicitSize: 16
        }
        
        NerdIcon {
          text: splitbutton.nerdIcon
          color: _primaryButton.textColor
          size: splitbutton.iconSize
          anchors.verticalCenter: parent.verticalCenter
        }

        ColumnLayout {
          spacing: 1
          
          SText {
            id: _title
            text: splitbutton.text
            color: _primaryButton.textColor            
            size: 9
            Layout.alignment: Qt.AlignVCenter
          }
          SText {
            id: _subtitle
            text: splitbutton.subtext
            visible: text !== ""
            size: 8
            color: _primaryButton.textColor            

            Layout.alignment: Qt.AlignVCenter
          }
        }
      }
    }

    SButton {
      id: _secondaryButton
      style: splitbutton.style
      nerdIcon: NerdIcon { 
        text: NerdIcons.chevron_right
        color: _secondaryButton.textColor
      }
      surface.topLeftRadius: 0
      highlighted: splitbutton.checked
      surface.bottomLeftRadius: 0
      surface.animated: true
      Layout.fillHeight: true
    }
  }
}
