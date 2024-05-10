-- We're using nvim.tree as our file explorer
-- This is the custom config for nvim.tree
local helpers = require "better-vim-core.helpers"
vim.g.nvim_tree_git_hl = 1

local custom_options = helpers.get_config_item { "nvim_tree" }
local default_options = {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = true,
  hijack_cursor = true,
  update_cwd = true,
  renderer = {
    root_folder_label = true,
    root_folder_modifier = table.concat { ":t:gs?$?/", string.rep(" ", 1000), "?:gs?^??" },
    highlight_opened_files = "all",
    highlight_git = true,
    add_trailing = true,
    special_files = {},
    indent_markers = {
      enable = false,
    },
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          deleted = "",
          ignored = "◌",
          renamed = "➜",
          staged = "✓",
          unmerged = "",
          unstaged = "",
          untracked = "",
        },
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "󱧮",
        },
      },
    },
  },
  filters = {
    custom = { ".git", "node_modules" },
  },
  git = {
    enable = true,
    ignore = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    adaptive_size = true,
    side = "right",
    width = 32,
  },
}

local nvim_tree_options = helpers.merge_tables(default_options, custom_options)
return nvim_tree_options
