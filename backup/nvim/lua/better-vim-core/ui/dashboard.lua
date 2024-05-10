local db = require "dashboard"
local helpers = require "better-vim-core.helpers"
local bettervimrc = require "better-vim-core.bettervimrc"
local dashboard_custom_header = helpers.get_config_item { "dashboard", "header" }

local padding = "         "

local function create_header()
  local total_lines = vim.api.nvim_win_get_height(0)
  local dashboard_lines = 9 + #dashboard_custom_header
  local empty_lines = math.floor((total_lines - dashboard_lines) / 2)
  local lines = {}
  for _ = 0, empty_lines do
    table.insert(lines, padding)
  end

  for _, v in ipairs(dashboard_custom_header) do
    table.insert(lines, v)
  end

  return lines
end

db.setup {
  theme = "doom",
  config = {
    header = create_header(),
    center = {
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Open explorer" .. padding,
        action = "NvimTreeToggle",
        key = "Ctrl+N",
        key_hl = "String",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Find file" .. padding,
        action = "Telescope find_files find_command=rg,--hidden,--files",
        key = "Ctrl+P",
        key_hl = "String",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Search word" .. padding,
        action = "Telescope live_grep",
        key = "Ctrl+F",
        key_hl = "String",
      },
    },
    footer = { ":BetterVim " .. vim.g.bettervimrc[bettervimrc.keys.version] },
  },
}
