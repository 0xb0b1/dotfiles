local fetch = require "better-vim-core.fetch"
local constants = require "better-vim-core.constants"
local bettervimrc = require "better-vim-core.bettervimrc"
local tasks_config_manager = require "better-vim-core.tasks.config-manager"

local M = {}

local get_difference_in_hours = function(reference)
  return os.difftime(os.time(), reference) / (60 * 60)
end

local fetch_flags = function()
  local success, response = pcall(function()
    return fetch("https://app.posthog.com/decide?v=3", {
      body = {
        api_key = constants.POSTHOG_API_KEY,
        distinct_id = vim.g.bettervimrc[bettervimrc.keys.license],
      },
    })
  end)
  if success and response then
    return { kind = "ok", value = response.body }
  else
    return { kind = "error" }
  end
end

local fetch_and_store = function(tasks_config)
  local result = fetch_flags()
  if result.kind == "ok" then
    local flags = vim.fn.json_decode(result.value)["featureFlags"]
    tasks_config.feature_flags.updated_at = os.time()
    tasks_config.feature_flags.flags = flags
    tasks_config_manager.set(tasks_config)
  end
end

M.init = function(tasks_config)
  if tasks_config and get_difference_in_hours(tasks_config.feature_flags.updated_at) > 1 then
    fetch_and_store(tasks_config)
  end
end

M.is_feature_enabled = function(tasks_config, flag_name)
  local flag = tasks_config.feature_flags.flags[flag_name]
  return flag and flag == true
end

return M
