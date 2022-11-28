require("tailwindcss-colors").setup()

require('nvim-ts-autotag').setup()

vim.opt.termguicolors = true
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_c = { "diff", "filename", "treesitter", "lsp",
  "filetype", "diagnostics", "encoding", "spaces" }

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "catppuccin-frappe"
--lvim.colorscheme = "onedarkpro"
--lvim.lang.javascript.format_on_save = true
--lvim.lang.typescript.format_on_save = true
--lvim.lang.typescriptreact.format_on_save = true
--lvim.lang.css.format_on_save = true
--lvim.lang.html.format_on_save = true
-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.nvimtree.setup.view.width = 45
lvim.builtin.nvimtree.setup.auto_reload_on_write = true
lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true

lvim.builtin.theme.tokyonight.options.lualine_bold = true

vim.opt.relativenumber = true


require("lvim.lsp.manager").setup "tailwindcss"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- Prettier configuration
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black" },
  {
    exe = "prettier",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "jsonc",
      "markdown",
      "css",
    },
  },
}

-- lvim.lang.typescript.formatter.exe = "eslint_d"
-- ESLint
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    exe = "eslint",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
    },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    exe = "eslint",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
    },
  },
}

-- Additional Plugins
lvim.plugins = {
  { "folke/trouble.nvim", cmd = "TroubleToggle", },
  { "drewtempelmeyer/palenight.vim", },
  { "catppuccin/nvim" },
  {
    "phaazon/hop.nvim",
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },
  { "yashguptaz/calvera-dark.nvim" },
  { "navarasu/onedark.nvim" },
  { "Th3Whit3Wolf/one-nvim" },
  { "olimorris/onedarkpro.nvim" },
  { "tiagovla/tokyodark.nvim" },
  { "themaxmarchuk/tailwindcss-colors.nvim" },
  { "styled-components/vim-styled-components" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "felipec/vim-sanegx",
    event = "BufRead",
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "alvan/vim-closetag",
    config = function()
      vim.cmd("let g:closetag_filenames = '*.html, *.xhtml, *.tsx, *.jsx'")
    end
  },
  {
    "andweeb/presence.nvim",
    config = function()
      vim.cmd("let g:presence_editing_text        = 'Editing %s'")
      vim.cmd("let g:presence_file_explorer_text  = 'Browsing %s'")
      vim.cmd("let g:presence_git_commit_text     = 'Committing changes'")
      vim.cmd("let g:presence_plugin_manager_text = 'Managing plugins'")
      vim.cmd("let g:presence_reading_text        = 'Reading %s'")
      vim.cmd("let g:presence_workspace_text      = 'Working on %s'")
      vim.cmd("let g:presence_line_number_text    = 'Line %s out of %s'")
      vim.cmd("let g:presence_auto_update         = 1")
      vim.cmd("let g:presence_neovim_image_text   = 'The One True Text Editor'")
      vim.cmd("let g:presence_main_image          = 'file'")
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },
}
