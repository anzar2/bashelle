-- General
hl.config({
  general = {
    gaps_in          = 5,
    gaps_out         = 20,
    border_size      = 2,
    col              = {
      active_border   = "rgba(33ccffee)",
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = true,
    allow_tearing    = false,
    layout           = "dwindle",
  },
})

-- Appearance
hl.config({
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
    }
  }
})

-- Input
hl.config({
  input = {
    kb_layout    = "us",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 1,

    sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad     = {
      natural_scroll = false,
      scroll_factor = 1
    },
  }
})
