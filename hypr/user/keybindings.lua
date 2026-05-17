-- NOTE: Its recommended to change this file
-- Direct changes on 'config/' or 'bashelle/' can break on updates.


-- Here, you should only add new keybinds (or disable the defaults)
-- To override existing keymaps see: 'user/keymaps.lua'.
-- Beware of shadowing keybindings! Can result on unexpected behaviors

-- Example
local default_keybinds = require("defaults.keybindings")
local keymaps = require("user.keymaps")
local vars = require("user.variables")

-- Disabling/undbinding
--    default_keybinds.open_file_manager:set_enabled(false)
--    default_keybinds.open_file_manager:unbind(keymaps.exec.file_manager)

-- You can set keymaps here if you want
--   keymaps.my_keymap = "SUPER+F"
--
-- Then:
--    hl.bind(
--      keymaps.my_keymap,
--      hl.dsp.exec_cmd(vars.file_manager)
--    )

-- You can hardcode a keymap
--    hl.bind("SUPER+Q", hl.dsp.window.close())
