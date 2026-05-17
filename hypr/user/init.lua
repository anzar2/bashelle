return {
  preload = function()
    -- Preload on 'bashelle.lua'
    require("user.variables")
    require("user.keymaps")
  end,
  load = function()
    -- Module loads on 'bashelle.lua'
    require("user.animations")
    require("user.general")
    require("user.autostart")
    require("user.input")
    require("user.env")
    require("user.monitors")
    require("user.keybindings")
    require("user.windowrules")
    require("user.workspaces")
  end
}
