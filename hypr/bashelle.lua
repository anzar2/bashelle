local user = require("user.init")
local function defaults()
  require("defaults.animations")
  require("defaults.config")
  require("defaults.autostart")
  require("defaults.env")
  require("defaults.keybindings")
  require("defaults.permissions")
  require("defaults.windowrules")
end

return {
  init = function()
    user.preload()
    defaults()
    user.load()
  end,
}
