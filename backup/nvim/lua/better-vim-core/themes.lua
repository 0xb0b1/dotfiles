local helpers = require "better-vim-core.helpers"
local is_auto_theme_loading_disabled = helpers.get_config_item { "flags", "disable_auto_theme_loading" }
local theme_name = helpers.get_config_item { "theme", "name" }

if is_auto_theme_loading_disabled then
  theme_name = ""
end

if theme_name == "rose-pine" then
  local rose_pine_options = helpers.get_config_item { "theme", "rose_pine" }
  require("rose-pine").setup(rose_pine_options)
end

-- Setting catppuccin color
if theme_name == "catppuccin" then
  require("catppuccin").setup {
    flavour = helpers.get_config_item { "theme", "catppuccin_flavour" },
    transparent_background = true,
    term_colors = true,
    compile = {
      enabled = true,
      path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "bold" },
      loops = { "bold" },
      functions = { "bold" },
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {},
    color_overrides = {},
    highlight_overrides = {
      all = function(colors)
        return {
          NormalFloat = { bg = colors.none },
        }
      end,
    },
  }
end

if theme_name == "ayu" then
  vim.cmd('let ayucolor = "' .. helpers.get_config_item { "theme", "ayucolor" } .. '"')
end

if theme_name == "nightfox" then
  local nightfox_options = helpers.get_config_item { "theme", "nightfox" }
  require("nightfox").setup(nightfox_options)
end

if not is_auto_theme_loading_disabled then
  vim.cmd("colorscheme " .. helpers.get_config_item { "theme", "name" })
end
