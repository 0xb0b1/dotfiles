local helpers = require "better-vim-core.helpers"
local utils = require "better-vim-utils"

local statusline_custom_sections = helpers.get_config_item { "lualine", "sections" }
local statusline_custom_options = helpers.get_config_item { "lualine", "options" }

require("lualine").setup {
  options = helpers.merge_tables({
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  }, statusline_custom_options),
  sections = {
    lualine_a = statusline_custom_sections.a or { "mode" },
    lualine_b = statusline_custom_sections.b or { utils.statusline.get_file_name },
    lualine_c = statusline_custom_sections.c or {},
    lualine_x = statusline_custom_sections.x or {},
    lualine_y = statusline_custom_sections.y or { "diagnostics" },
    lualine_z = statusline_custom_sections.z or { "filetype" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}
