import QtQuick
import qs.utils
import QtQuick.Layouts
import qs.theme

SRectangle {
  id: splitbutton
  property bool checked: false
  property string text
  property string subtext
  property string nerdIcon
  property alias primaryButton: _primaryButton
  property alias secondaryButton: _secondaryButton
  property color textColor: checked ? Theme.colors.surface : Theme.colors.secondary
  color: Theme.colors.surface_container_high

  implicitHeight: row.height + padding * 2
  showBorder: true
  border.color: Theme.colors.surface_container_high
  padding: 1

  RowLayout {
    id: row
    spacing: 1
    width: parent.width
    
    SButton {
      id: _primaryButton
      surface.topRightRadius: 0
      surface.bottomRightRadius: 0
      flat: !splitbutton.checked
      
      surface.animated: true
      flatStyle: ({
        background: Theme.colors.surface_container_low,
        backgroundHovered: Theme.colors.surface_container
      })

      text: "Button"
      Layout.fillWidth: true
      contentItem: RowLayout {
        NerdIcon {
          text: splitbutton.nerdIcon
          color: splitbutton.textColor
        }

        ColumnLayout {
          spacing: 1
          SText {
            id: _title
            text: splitbutton.text
            color: splitbutton.textColor            
            size: 9
          }
          SText {
            id: _subtitle
            text: splitbutton.subtext
            visible: text !== ""
            size: 8
            color: splitbutton.textColor
          }
        }
      }
    }

    SButton {
      id: _secondaryButton
      nerdIcon.text: NerdIcons.chevron_right
      surface.topLeftRadius: 0
      surface.bottomLeftRadius: 0
      flat: !splitbutton.checked
      surface.animated: true
      flatStyle: ({
        background: Theme.colors.surface_container_low,
        backgroundHovered: Theme.colors.surface_container
      })
      Layout.fillHeight: true
    }
  }
}
