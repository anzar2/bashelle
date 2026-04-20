import qs.config

SegmentedControl {
  currentIndex: Config.theme === "dark"

  SegmentedButton {
    nerdIcon.text: ""
    onClicked: Config.theme = "light"
  }

  SegmentedButton {
    nerdIcon.text: ""
    onClicked: Config.theme = "dark"
  }
}