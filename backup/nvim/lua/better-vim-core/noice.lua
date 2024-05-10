local helpers = require "better-vim-core.helpers"

local noice_custom_config = helpers.get_config_item { "noice" }
local noice_defaults = {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    progress = {
      enabled = false,
    },
    hover = {
      enabled = false,
    },
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  messages = {
    view_search = false,
  },
  routes = {
    {
      filter = { event = "notify", find = "No information available" },
      opts = { skip = true },
    },
    {
      filter = { error = true, find = "change; before" },
      opts = { skip = true },
    },
    {
      filter = { error = true, find = "changes; before" },
      opts = { skip = true },
    },
  },
}

return helpers.merge_tables(noice_defaults, noice_custom_config)
