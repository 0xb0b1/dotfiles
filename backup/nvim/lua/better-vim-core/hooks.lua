local helpers = require "better-vim-core.helpers"

local M = {}

M.after_setup = function()
  local after = helpers.get_config_item { "hooks", "after_setup" }

  if after ~= nil then
    after()
  end
end

M.before_setup = function()
  local before = helpers.get_config_item { "hooks", "before_setup" }
  if before ~= nil then
    before()
  end
end

return M
