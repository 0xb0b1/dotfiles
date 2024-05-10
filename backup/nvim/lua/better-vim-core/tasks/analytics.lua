local bettervimrc = require "better-vim-core.bettervimrc"
local tasks_config_manager = require "better-vim-core.tasks.config-manager"
local helpers = require "better-vim-core.helpers"
local fetch = require "better-vim-core.fetch"
local constants = require "better-vim-core.constants"
local feature_flags = require "better-vim-core.tasks.feature-flags"

local M = {}

local update_last_report_time = function(config)
  local now = os.time()
  config.analytics.last_report = now
  tasks_config_manager.set(config)
end

local send_report = function()
  local bettervimrc_config = vim.g.bettervimrc
  local license = bettervimrc_config[bettervimrc.keys.license]
  local version = bettervimrc_config[bettervimrc.keys.version]
  local properties = {
    distinct_id = license,
    bettervim_version = version,
    unloaded_plugins = helpers.get_config_item { "unload_plugins" },
    theme = helpers.get_config_item { "theme", "name" },
    leader = helpers.get_config_item { "mappings", "leader" },
    flags = helpers.get_config_item { "flags" },
    treesitter = helpers.get_config_item { "treesitter" },
  }

  local success, response = pcall(function()
    fetch("https://app.posthog.com/capture/", {
      body = {
        api_key = constants.POSTHOG_API_KEY,
        event = "loaded",
        properties = properties,
      },
    })
  end)

  if success then
    return response
  else
    error "Failed to send analytics data. This error could be due to a temporary issue with your internet connection. You may choose to ignore this error if you believe your connection is stable."
  end
end

local get_difference_in_hours = function(reference)
  return os.difftime(os.time(), reference) / (60 * 60)
end

local check_time_and_send_report = function(config)
  local should_send_report = get_difference_in_hours(config.analytics.last_report) > 2
  if should_send_report then
    update_last_report_time(config)
    send_report()
  end
end

local accept_and_send = function(tasks_config)
  tasks_config.analytics.consent_status = tasks_config_manager.consent_enum.accepted
  tasks_config_manager.set(tasks_config)
  check_time_and_send_report(tasks_config)
end

local declined_and_save = function(tasks_config)
  tasks_config.analytics.consent_status = tasks_config_manager.consent_enum.denied
  tasks_config_manager.set(tasks_config)
end

local select_labels = {
  yes = "Yes, sure.",
  no = "No.",
  read_more = "I'd like to learn more about your analytics policy.",
  title = "We collect anonymized data to improve BetterVim. Do you accept?",
}

local select_options = { select_labels.yes, select_labels.no, select_labels.read_more }

local ask_again = function(tasks_config)
  vim.ui.select({ select_labels.yes, select_labels.no }, { prompt = select_labels.title }, function(answer)
    if answer == select_labels.yes then
      accept_and_send(tasks_config)
    else
      declined_and_save(tasks_config)
    end
  end)
end

local open_website = function(url)
  local platform = vim.fn.system("uname"):gsub("\n", "")

  if platform == "Linux" then
    vim.fn.system(string.format("xdg-open %s", url))
  elseif platform == "Darwin" then
    vim.fn.system(string.format("open %s", url))
  elseif platform == "Linux" and vim.fn.executable "wslview" == 1 then
    vim.fn.system(string.format("wslview %s", url))
  end
end

M.init = function(tasks_config)
  if tasks_config == nil then
    error "Failed to load the core configuration. You can ignore this error for now, if the error persists please contact support for assistance via bettervim@gmail.com"
  end

  if not feature_flags.is_feature_enabled(tasks_config, "ANALYTICS") then
    return
  end

  local consent_status = tasks_config and tasks_config.analytics.consent_status

  if consent_status == tasks_config_manager.consent_enum.not_asked then
    vim.ui.select(select_options, { prompt = select_labels.title }, function(answer)
      if answer == select_labels.yes then
        accept_and_send(tasks_config)
      elseif answer == select_labels.no then
        declined_and_save(tasks_config)
      elseif answer == select_labels.read_more then
        open_website "https://docs.bettervim.com/"
        ask_again(tasks_config)
      end
    end)
  end

  if consent_status == tasks_config_manager.consent_enum.accepted then
    check_time_and_send_report(tasks_config)
  end
end

return M
