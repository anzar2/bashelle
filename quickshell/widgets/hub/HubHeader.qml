import QtQuick.Layouts
import qs.components
import QtQuick
import qs.theme
import qs.utils
import qs.services

RowLayout {
  id: header

  SegmentedControl {
    currentIndex: Widgets.hub.lastTabIndex
    onCurrentIndexChanged: Widgets.hub.lastTabIndex = currentIndex

    SegmentedButton {
      nerdIcon.text: {
        if (Widgets.notification.dnd) return "󱋑"
        if (Notifications.count > 0) return "󰭻"
        return "󰻞"
      }
      onClicked: Widgets.hub.lastTabIdentifier = "notifications"
    }

    SegmentedButton {
      nerdIcon.text: "󰫔"
      onClicked: Widgets.hub.lastTabIdentifier = "mpris"
    }  

  }

  Item {
    Layout.fillWidth: true
  }
  
  SButton {
    onClicked: Widgets.hub.toggleExpanded()
    nerdIcon.text: Widgets.hub.expanded ?  NerdIcons.chevron_down : NerdIcons.chevron_up
  }
}
