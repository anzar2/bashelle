import qs.components
import qs.services
import qs.config

SButton {
  nerdIcon.size: 13
  nerdIcon.text: Config.panel.isVertical() ? "󰇘" : "󰇙"
  onClicked: Widgets.hub.toggle()
}
