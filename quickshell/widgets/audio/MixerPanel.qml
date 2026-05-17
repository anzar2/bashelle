pragma ComponentBehavior: Bound
import qs.utils
import qs.components
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Pipewire

SListView {
  id: root
  property string scope: "source"
  
  implicitWidth: parent ? parent.width : 300
  implicitHeight: Math.min(contentHeight, 300)
  
  delegate: ColumnLayout {
    id: media
    required property PwLinkGroup modelData
    property PwNode source:     root.scope === "source" ? modelData.source : modelData.target
    property string appName:    source.properties["application.name"]
    property string mediaName:  source.properties["media.name"]
    property string binName:    source.properties["application.process.binary"]
    property real   volume:     source.audio.volume
    property var    volumeIcon: source.audio.muted ? NerdIcons.volume_muted : NerdIcons.volume_high
    
    width: parent.width
    spacing: 0
    
    SButton {
      icon.name: IconsMap.get(media.binName)
      text: `${media.mediaName}`
      opacity: media.source.audio.muted ? 0.5 : 1
      enabled: false
      textItem.font.capitalization: Font.Capitalize
      textItem.size: 8
      Layout.fillWidth: true
    }

    AudioControl {
      button.nerdIcon: NerdIcon { text: "󱄠" }
      button.onClicked: media.source.audio.muted = !media.source.audio.muted

      slider.implicitHeight: 8
      slider.value: media.volume
      slider.onMoved: media.source.audio.volume = slider.value
      slider.opacity: media.source.audio.muted ? 0.5 : 1
      label.text: Math.round(media.volume * 100)
      
      Layout.rightMargin: 8
    }
  }
  Layout.fillWidth: true
  Layout.preferredHeight: Math.min(contentHeight + 16, 300)
}
