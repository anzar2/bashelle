pragma ComponentBehavior: Bound
import qs.components
import qs.services.pipewire
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import qs.config
import Quickshell
import qs.utils

WidgetComponent {
  id: widget
  property PwNode node: null
  property list<PwNode> devices: []
  property list<PwLinkGroup> linkGroups: []
  property string controlIcon: ""
  property string devicesIcon: ""
  property Component control: null
  property Component mixer: null
  signal deviceSelected(PwNode node)
  focusGrab.active: true

  implicitWidth: 300
  color: "transparent"

  mask: Region { item: content }

  openAnimation: NumberAnimation {
    target: content
    property: "x"
    from:  Config.panel.isLeft() ? -widget.width : widget.width
    to: 0
  }

  hideAnimation: NumberAnimation {
    target: content
    property: "x"
    to:  Config.panel.isLeft() ? -widget.width : widget.width
  }

  anchors {
    top:    true
    bottom: true
    left:   Config.panel.isLeft()
    right: !Config.panel.isLeft()
  }

  SRectangle {
    id: content
    implicitWidth: parent.width
    implicitHeight: column.height + padding * 2
    anchors.bottom: Config.panel.isVertical() || Config.panel.isBottom() ? parent.bottom : undefined
    anchors.top: Config.panel.isTop() ? parent.top : undefined
    padding: 8
    showBorder: true
    shadowEnabled: true

    ColumnLayout {
      id: column
      implicitWidth: parent.width

      Loader {
        sourceComponent: widget.control
        Layout.fillWidth: true
        Layout.rightMargin: 12
      }

      Separator { Layout.fillWidth: true }

      Accordion {
        id: deviceAccordion
        Component.onCompleted: expanded = true
        
        button: SButton {
          implicitWidth: parent.width
          text: "Devices"
          onClicked: deviceAccordion.toggle()
          nerdIcon: NerdIcon { text: widget.devicesIcon }

          NerdIcon {
            text: NerdIcons.chevron_down
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 6
            rotation: deviceAccordion.expanded ? 180 : 0
          }
        }
        body: SListView {
          spacing: 0
          implicitWidth: parent.width
          implicitHeight: contentHeight + 16
          model: widget.devices
          delegate: SRadioButton {
            required property PwNode modelData
            implicitWidth: parent.width
            text: modelData.description
            checked: modelData.id === widget.node.id
            onClicked: widget.deviceSelected(modelData)
          }
        }
      }
      
      Accordion {
        id: accordion
        button: SButton {
          implicitWidth: parent.width
          text: "Applications"
          onClicked: accordion.toggle()
          nerdIcon: NerdIcon { text: NerdIcons.apps }
          highlighted: accordion.expanded

          NerdIcon {
            id: chevronicon
            text: NerdIcons.chevron_down
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 6
            rotation: accordion.expanded ? 180 : 0
          }

          SText {
            text: widget.linkGroups.length
            anchors.right: chevronicon.left
            anchors.top: parent.top
            anchors.margins: 6
            size: 8
          }
        }

        body: Loader {
          sourceComponent: widget.mixer
          anchors.leftMargin: 16
        }
        Layout.fillWidth: true
      }
    }

  }
}
