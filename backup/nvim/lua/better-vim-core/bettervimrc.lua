local constants = require "better-vim-core.constants"

local M = {}

M.path = constants.CONFIG_PATH .. "/.bettervimrc"

M.init = function()
  if vim.g.bettervimrc == nil then
    local values = {}
    local file = io.open(M.path, "rb")

    if file then
      for line in file:lines() do
        local key, value = line:match "export ([^=]+)=(.+)"
        local unquoted_value = value:match '^"(.*)"$' or value:match "^'(.*)'$" or value
        values[key] = unquoted_value
      end
      vim.g.bettervimrc = values
    end
  end
end

M.keys = {
  license = "BETTER_VIM_LICENSE",
  version = "BETTER_VIM_VERSION",
}

return M
