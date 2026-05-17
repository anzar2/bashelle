local default_monitor = 0
local persistent = { 1, 2, 3, 4, 5 }

local monitor = hl.get_monitor(default_monitor)

for _, i in ipairs(persistent) do
  hl.workspace_rule({
    workspace = tostring(i),
    persistent = true,
    default = i == 1,
    monitor = monitor and monitor.name or nil,
  })
end
