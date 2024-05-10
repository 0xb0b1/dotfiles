return {
  plugins = {},
  unload_plugins = {},
  lsps = {},
  formatters = {},
  treesitter = {},
  gitsigns = {},
  noice = {},
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
    format_on_save = false,
    experimental_tsserver = false,
  },
  hooks = {},
  mappings = {
    leader = " ",
    tabs = nil,
    custom = {},
    by_mode = {
      n = {},
      i = {},
      v = {},
      x = {},
    },
  },
  lualine = {
    options = {},
    sections = {},
  },
  telescope = {},
  nvim_tree = {},
  whichkey = {},
  dashboard = {
    header = {},
  },
}
