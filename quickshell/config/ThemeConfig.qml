import Quickshell.Io
import Quickshell

JsonObject {
  property string _currentScheme: "unset"
  property string scheme: "unset"
  property string iconsLight: "Papirus-Light"
  property string iconsDark: "Papirus-Dark"

  onSchemeChanged: {
    if (scheme === "unset") return;

    if (_currentScheme === "unset") {
      _currentScheme = scheme
      return
    }

    _currentScheme = scheme
    Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/scripts/change_theme.sh " + scheme])
  }
}
