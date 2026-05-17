if true then return {} end -- WARN: Delete this line to load this file


-- Example
-- See: https://wiki.hypr.land/Configuring/Basics/Binds/#switchable-keyboard-layouts

hl.config({
  input = {
    kb_layout    = "latam",

    follow_mouse = 1,

    sensitivity  = 0,

    touchpad     = {
      natural_scroll = true,
      scroll_factor = 0.2
    }
  }
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Configure your devices directly
-- See: https://wiki.hypr.land/Configuring/Basics/Binds/#per-device-binds
