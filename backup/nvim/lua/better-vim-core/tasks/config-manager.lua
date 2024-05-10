local constants = require "better-vim-core.constants"

local M = {}
local path = constants.CONFIG_PATH .. "/.bettervim.json"

M.consent_enum = {
  accepted = "accepted",
  denied = "denied",
  not_asked = "not-asked",
}

local initial_config = {
  analytics = {
    last_report = 0,
    consent_status = "not-asked",
  },
  feature_flags = {
    updated_at = 0,
    flags = {},
  },
}

local unexpected_error_message =
  "Oops! Something unexpected happened with BetterVim while trying to run core tasks. Please contact support for assistance via bettervim@gmail.com"

M.set = function(updated_config)
  local file = io.open(path, "w")
  if file then
    local encoded = vim.fn.json_encode(updated_config)
    file:write(encoded)
    io.close(file)
  end
end

M.get = function()
  local _get = function()
    local file = io.open(path, "r")
    if file then
      local content = file:read "*all"
      local config = vim.fn.json_decode(content)
      file:close()
      return config
    else
      file = io.open(path, "w")
      if file then
        local encoded = vim.fn.json_encode(initial_config)
        file:write(encoded)
        io.close(file)
        return initial_config
      else
        error(unexpected_error_message)
      end
    end
  end

  local success, config = pcall(_get)
  if success then
    return config
  else
    error(unexpected_error_message)
  end
end

return M
