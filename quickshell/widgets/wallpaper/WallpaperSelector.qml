import qs.components
import qs.services
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import qs.config
import qs.theme
import Quickshell
import qs.utils

WidgetComponent {
  id: widget
  property bool expanded: false
  controller: Widgets.wallpaperSelector
  color: "transparent"
  implicitWidth: 650
  implicitHeight: 250
  focusable: true
  focusGrab: true

  onFocusLost: Widgets.wallpaperSelector.hide()
  onEscapePressed: Widgets.wallpaperSelector.hide()

  openAnimation: NumberAnimation {
    target: content
    property: "y"
    from: widget.implicitHeight
    to: 0
    easing.type: Easing.OutQuart
  }

  hideAnimation: NumberAnimation {
    target: content
    property: "y"
    to: widget.implicitHeight
    easing.type: Easing.InQuart
  }

  FolderListModel {
    id: fileModel
    folder: "file://" + "/home/anzar/.config/wallpapers" 
    nameFilters: ["*.jpg", "*.jpeg"]
  }

  mask: Region {
    item: content
  }

  anchors {
    bottom: true
  }

  SRectangle {
    id: content
    implicitHeight: parent.height
    implicitWidth: parent.width
    padding: 8
    shadowEnabled: true
    animated: true

    ColumnLayout {
      anchors.fill: parent
      spacing: 8

      WallpaperCarousel {
        id: carousel
        Layout.fillWidth: true
        Layout.fillHeight: true
        model: fileModel
      }

      RowLayout {
        Layout.fillWidth: true
        
        SButton {
          nerdIcon.text: "󰣞"
        }  
        
        Item { Layout.fillWidth: true }
        SButton {
          text: widget.screen.name
          nerdIcon.text: "󰍹"
        }
        
        SButton {
          id: adjustButton
          text: "Fill"
          nerdIcon.text: "󱣴"
        }

        Item { Layout.fillWidth: true }
        
        SButton {
          text: "Aplicar"
          color: Theme.colors.primary
          textColor: Theme.colors.surface
          onClicked: Scripts.setWallpaper(Config.theme, carousel.currentWallpaper)
        }
      }
    }    
  }
}
