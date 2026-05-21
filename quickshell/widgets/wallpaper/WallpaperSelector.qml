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
        nerdIcon: NerdIcon { text: NerdIcons.close }        
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
          nerdIcon: NerdIcon { text: NerdIcons.folder }        
          surface.showBorder: true
          onClicked: Xdg.open(Config.wallpapers.folder)
        }

        SComboBox {
          id: resizeMenu
          model: [
            { text: "Crop",   icon: NerdIcons.crop,           data: "crop" },
            { text: "Fit",    icon: NerdIcons.fit_to_screen,  data: "fit" },
            { text: "Center", icon: NerdIcons.image_center,   data: "no" },
          ]
        }

        SComboBox {
          id: monitorsMenu
          model: [
            { text: "All", icon: NerdIcons.monitor, data: Quickshell.screens.map(screen => screen.name).join(",")},
            ...Quickshell.screens.map(s => ({ text: s.name, icon: NerdIcons.monitor, data: s.name }))
          ]
        }

        Item { Layout.fillWidth: true }    

        ThemeSelector { showBorder: true }

        SButton {
          id: applyButton
          text: "Apply"
          style: Styles.button.filled
          onClicked: {
            if (Config.appearance.accentColor === "auto") {
              Matugen.image(carousel.currentWallpaper, Config.appearance.theme)
            }

            Awww.setImage(carousel.currentWallpaper, {
              outputs:    monitorsMenu.currentValue.data,
              resizeMode: resizeMenu.currentValue.data
            })
          }
          implicitWidth: 50
        }
      }

    }    
  }
}
