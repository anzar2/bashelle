local km             = require("defaults.keymaps")
local vars           = require("defaults.variables")
local kb             = {}

kb.open_terminal     = hl.bind(km.exec.terminal, hl.dsp.exec_cmd(vars.terminal))
kb.open_launcher     = hl.bind(km.exec.launcher, hl.dsp.exec_cmd(vars.launcher))
kb.open_file_manager = hl.bind(km.exec.file_manager, hl.dsp.exec_cmd(vars.file_manager))
kb.screenshot        = hl.bind(km.exec.screenshot, hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -"))

kb.close_window      = hl.bind(km.window.close, hl.dsp.window.close())
kb.toggle_float      = hl.bind(km.window.toggle_float, hl.dsp.window.float({ action = "toggle" }))
kb.toggle_pseudo     = hl.bind(km.window.toggle_pseudo, hl.dsp.window.pseudo())
kb.toggle_split      = hl.bind(km.window.toggle_split, hl.dsp.layout("togglesplit")) -- dwindle only
kb.maximize          = hl.bind(km.window.maximize, hl.dsp.window.fullscreen({ mode = "maximized" }))
kb.fullscreen        = hl.bind(km.window.fullscreen, hl.dsp.window.fullscreen({ mode = "fullscreen" }))

kb.focus_left        = hl.bind(km.window.focus_left, hl.dsp.focus({ direction = "left" }))
kb.focus_right       = hl.bind(km.window.focus_right, hl.dsp.focus({ direction = "right" }))
kb.focus_up          = hl.bind(km.window.focus_up, hl.dsp.focus({ direction = "up" }))
kb.focus_down        = hl.bind(km.window.focus_down, hl.dsp.focus({ direction = "down" }))

kb.move_next         = hl.bind(km.window.move_next, hl.dsp.focus({ workspace = "e+1" }))
kb.move_prev         = hl.bind(km.window.move_prev, hl.dsp.focus({ workspace = "e-1" }))

kb.toggle_special    = hl.bind(km.workspaces.toggle_special, hl.dsp.workspace.toggle_special("magic"))
kb.move_to_special   = hl.bind(km.workspaces.move_special, hl.dsp.window.move({ workspace = "special:magic" }))

kb.session_exit      = hl.bind(km.session.exit,
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(vars.mainMod .. "+" .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(vars.mainMod .. "+SHIFT+" .. key, hl.dsp.window.move({ workspace = i }))
end


hl.bind(vars.mainMod .. "+mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.mainMod .. "+mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(vars.mainMod .. "+mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(vars.mainMod .. "+mouse:273", hl.dsp.window.resize(), { mouse = true })

kb.volume_up   = hl.bind(km.media.volume_up,
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })

kb.volume_down = hl.bind(km.media.volume_down,
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })

kb.mute_volume = hl.bind(km.media.mute_volume,
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })

kb.mute_mic    = hl.bind(km.media.mute_mic,
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })

kb.bright_up   = hl.bind(km.screen.bright_up, hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
  { locked = true, repeating = true })

kb.bright_down = hl.bind(km.screen.bright_down, hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
  { locked = true, repeating = true })

-- Requires playerctl
kb.next_audio  = hl.bind(km.media.next_audio, hl.dsp.exec_cmd("playerctl next"), { locked = true })
kb.pause_audio = hl.bind(km.media.pause_audio, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
kb.play_audio  = hl.bind(km.media.play_audio, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
kb.prev_audio  = hl.bind(km.media.prev_audio, hl.dsp.exec_cmd("playerctl previous"), { locked = true })

return kb
