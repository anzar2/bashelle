import QtQuick.Layouts
import qs.components
import QtQuick
import qs.theme
import qs.utils
import qs.services

RowLayout {
  id: header

  TabRow {
    id: tabrow
    
    Component.onCompleted: setTab(Widgets.hub.lastTabIndex)
    
    onCurrentTabChanged: {
      Widgets.hub.lastTabIndex = currentTab.index
      Widgets.hub.lastTabIdentifier = currentTab.identifier
    }
    
    fillIndicator: false
    fillWidth: false

    Tab {
      index: 0
      identifier: "notifications"
      nerdIcon.text: {
        if (Widgets.notification.dnd) {
          return "󰒲"
        }
        return active ? "󰍨":"󱜽"
      } 
      tabRow: tabrow
    }

    Tab {
      index: 1
      identifier: "mpris"
      nerdIcon.text: active ? "󰎆":"󰫔"
      tabRow: tabrow
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
