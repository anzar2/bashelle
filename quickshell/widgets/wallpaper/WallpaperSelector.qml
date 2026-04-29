import qs.components
import qs.services
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import qs.config
import qs.theme
import Quickshell
import qs.utils
import QtQuick.Controls

WidgetComponent {
  id: widget
  property bool expanded: false
  controller: Widgets.wallpaperSelector
  focusGrab.active: true
  focusGrab.windows: [widget]
  color: "transparent"
  implicitWidth: 650
  implicitHeight: 250
  focusable: true

  onFocusLost: Widgets.wallpaperSelector.hide()
  onEscapePressed: Widgets.wallpaperSelector.hide()
  mask: Region { item: content }
  anchors { bottom: true }
  
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
    folder: Config.wallpapers.folderPath()
    nameFilters: ["*.jpg", "*.jpeg", "*.gif", "*.png"]
  }


  ListModel {
    id: resizeModel
    ListElement { text: "Crop";  icon: "󰆞"; data: "crop" }
    ListElement { text: "Fit"; icon: "󱣴"; data: "fit" }
    ListElement { text: "Center"; icon: "󰋱"; data: "no" }
  }

  ListModel {
    id: monitorsModel
    
    ListElement { text: "All"; icon: "󰍹"; data: "all" }

    Component.onCompleted: {
      for (let screen of Quickshell.screens) {
        append({ text: screen.name, icon: "󰍹", data: screen.name })
      }
    }
    
  }

  SRectangle {
    id: content
    implicitHeight: parent.height
    implicitWidth: parent.width
    padding: 8
    shadowEnabled: true
    focus: true

    Keys.onRightPressed: carousel.incrementCurrentIndex()
    Keys.onLeftPressed: carousel.decrementCurrentIndex()
    Keys.onReturnPressed: applyButton.clicked()

    ColumnLayout {
      anchors.fill: parent
      spacing: 6
      
      SButton {
        nerdIcon.text: NerdIcons.close
        onClicked: Widgets.wallpaperSelector.hide()
        Layout.alignment: Qt.AlignRight
      }


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
          surface.showBorder: true
          onClicked: Xdg.open(Config.wallpapers.folder)
        }

        SComboBox {
          id: resizeMenu
          model: resizeModel
        }

        SComboBox {
          id: monitorsMenu
          model: monitorsModel
        }

        Item { Layout.fillWidth: true }    

        ThemeSelector { showBorder: true }

        SButton {
          id: applyButton
          text: "Apply"
          flat: false
          onClicked: Scripts.setWallpaper(
            Config.theme, 
            carousel.currentWallpaper,
            resizeMenu.currentValue.data,
            monitorsMenu.currentValue.data
          )
        }
      }

    }    
  }
}
