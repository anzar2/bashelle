local vars = require("defaults.variables")
return {
  exec       = {
    terminal     = vars.mainMod.."+Q",
    file_manager = vars.mainMod.."+E",
    launcher     = vars.mainMod.."+"..vars.mainMod.."_L",
    screenshot   = vars.mainMod.."+CTRL+S"
  },
  window     = {
    close         = vars.mainMod.."+C",
    toggle_pseudo = vars.mainMod.."+P",
    toggle_split  = vars.mainMod.."+J",
    toggle_float  = vars.mainMod.."+V",
    focus_right   = vars.mainMod.."+right",
    focus_left    = vars.mainMod.."+left",
    focus_up      = vars.mainMod.."+up",
    focus_down    = vars.mainMod.."+down",
    maximize      = vars.mainMod.."+RETURN",
    fullscreen    = "F11",
    move_next     = vars.mainMod.."+period",
    move_prev     = vars.mainMod.."+comma"
  },
  workspaces = {
    toggle_special = vars.mainMod.."+S",
    move_special   = vars.mainMod.."+SHIFT+S"
  },
  media      = {
    volume_up   = "XF86AudioRaiseVolume",
    volume_down = "XF86AudioLowerVolume",
    mute_volume = "XF86AudioMute",
    mute_mic    = "XF86AudioMicMute",
    next_audio  = "XF86AudioNext",
    prev_audio  = "XF86AudioPrev",
    pause_audio = "XF86AudioPause",
    play_audio  = "XF86AudioPlay"
  },
  screen     = {
    bright_up   = "XF86MonBrightnessUp",
    bright_down = "XF86MonBrightnessDown",
  },
  session    = {
    exit = vars.mainMod.."+ESCAPE"
  }
}
