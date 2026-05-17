if true then return {} end -- WARN: Delete this line to load this file
-- Add your animations here
-- Defaults: 'bashelle/animations.lua'

-- See: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.config({
  animations = { enabled = true }
})

-- Example
hl.animation({
  leaf = "workspacesIn",
  enabled = true,
  speed = 1.21,
  bezier = "almostLinear",
  style = "slide"
})

hl.animation({
  leaf = "workspacesOut",
  enabled = true,
  speed = 1.94,
  bezier = "almostLinear",
  style = "slide"
})
