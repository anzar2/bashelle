import qs.config
import qs.utils

SegmentedControl {
  id: control
  property bool showLabel: false
  currentIndex: Config.theme === "dark"

  SegmentedButton {
    nerdIcon.text: NerdIcons.sun
    text: control.showLabel ? "Light" : ""
    onClicked: Config.theme = "light"
  }

  SegmentedButton {
    nerdIcon.text: NerdIcons.moon
    text: control.showLabel ? "Dark" : ""
    onClicked: Config.theme = "dark"
  }
}