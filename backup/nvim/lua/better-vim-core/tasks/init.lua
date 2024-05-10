local async = require "plenary.async"
local analytics = require "better-vim-core.tasks.analytics"
local feature_flags = require "better-vim-core.tasks.feature-flags"
local tasks_config_manager = require "better-vim-core.tasks.config-manager"
local helpers = require "better-vim-core.helpers"
local bettervimrc = require "better-vim-core.bettervimrc"

if helpers.is_a_prerelease(vim.g.bettervimrc[bettervimrc.keys.version]) then
  async.run(function()
    local tasks_config = tasks_config_manager.get()
    feature_flags.init(tasks_config)
    analytics.init(tasks_config)
  end)
end
