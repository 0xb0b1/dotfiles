local helpers = require "better-vim-core.helpers"

local function local_tabs_mapping(tab)
  return "<M-" .. tab .. ">"
end

-- Adding mappings to bufferline
local tab = 0
repeat
  local get_tabs_mapping = helpers.get_config_item { "mappings", "tabs" } or local_tabs_mapping
  vim.cmd('nnoremap <silent>' .. get_tabs_mapping(tab) .. ' <cmd>lua require("bufferline").go_to(' .. tab .. ')<cr>')
  tab = tab + 1
until tab == 20

if not helpers.get_config_item { "flags", "disable_tabs" } then
  require("bufferline").setup {
    highlights = {
      buffer_selected = {
        italic = false,
      },
    },
    options = {
      show_close_icon = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = " Explorer",
          highlight = "NvimTreeNormal",
          text_align = "left",
        },
      },
    },
  }
end
