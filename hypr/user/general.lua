if true then return {} end -- WARN: Delete this line to load this file

-- See: https://wiki.hypr.land/Configuring/Basics/Variables/#general

-- Colors are generated with matugen
-- if 'colors.lua' don't exist this will fail!
-- It should work out of the box
local colors = require("colors")

-- Appearance
hl.config({
  general = {
    gaps_in     = 5,
    gaps_out    = 20,
    border_size = 2,

    col         = {
      active_border = colors.primary
    },
    layout      = "dwindle"
  },
  decoration = {
    rounding         = 10,
    rounding_power   = 2,

    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  }
})

-- Other config
hl.config({
  misc = {
    disable_hyprland_logo = true,
    -- Some MP games crashes on lower FPS..
    -- it may be useful set this to 30.
    -- (Default is 15)
    render_unfocused_fps = 30
  },
  dwindle = {
    preserve_split = true
  },
  scrolling = {
    direction = "right"
  }
})
