import QtQuick
import Quickshell

import qs.Components.Controls
import qs.Components
import qs.Services.Xdg
import qs.Utils
import qs.Config

SMenu {
  SMenuItem {
    text: "Reload"
    nerdIcon.text: NerdIcons.reload
    onClicked: {
      Quickshell.reload(false)
    }
  }

  SMenuItem {
    text: "Files"
    nerdIcon.text: NerdIcons.folder
    onClicked: Xdg.open()
  }

  SMenuItem {
    text: "Terminal"
    nerdIcon.text: NerdIcons.terminal
    nerdIcon.size: 12
    onClicked: Xdg.openTerminal()
  }

  Separator {}

  SMenu {
    title: "Panel"
    icon.name: NerdIcons.layout
    implicitWidth: 150

    Repeater {
      model: ["top", "right", "left", "bottom"]
      delegate: SMenuItem {
        required property string modelData
        text: `Move ${modelData}`

        onClicked: Config.panel.setPosition(modelData)
      }
    }
  }
}

