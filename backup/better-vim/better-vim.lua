------------
-- Generated by BetterVim
------------
local generated_plugins_list = {
  { "neovim/nvim-lspconfig" },
  { "kabouzeid/nvim-lspinstall" },
}

return {
  theme = {
    name = "catppuccin",
    catppuccin_flavour = "macchiato",
    ayucolor = "mirage",
    nightfox = {},
    rose_pine = {
      dark_variant = "moon",
    },
  },
  flags = {
    disable_auto_theme_loading = false,
    disable_tabs = false,
    format_on_save = true,
    experimental_tsserver = false,
  },
  nvim_tree = {
    filters = {
      dotfiles = true
    },
  },
  lualine = {
    sections = { c = { "branch" } },
  },
  treesitter = { "javascript", "typescript", "lua", "clojure", "python" },
  plugins = {
    "f-person/git-blame.nvim",
    "github/copilot.vim",
    "nvim-lua/plenary.nvim",
    {
      "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end
    },
  },
  hooks = {
    after_setup = function()
      vim.cmd [[ set relativenumber ]]
    end,
  }
}