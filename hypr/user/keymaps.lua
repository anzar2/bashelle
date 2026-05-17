-- NOTE: Its recommended to change this file
-- Direct changes on 'config/' or 'bashelle/' can break on updates.

-- You can change defaults keymaps at your taste,
-- See defaults: bashelle/keymaps.lua

local defaults = require("defaults.keymaps")
-- Example
--    defaults.exec.terminal = "SUPER+T"
--    defaults.exec.file_manager = "SUPER+F"
--    defaults.exec.launcher = "SUPER+R"
--
-- Create a keymap on exec category
--    defaults.exec.amogus = "SUPER+O"
--
-- Create your own category
--    defaults.custom = { soemething = "SUPER+O" }
--
return defaults
