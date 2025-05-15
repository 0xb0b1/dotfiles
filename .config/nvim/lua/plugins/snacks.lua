return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    layout = { enabled = true },
    rename = { enabled = true },
    toggle = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    picker = {
      sources = {
        explorer = {
          layout = {
            preset = function()
              return "telescope"
            end,
          },
          matcher = {
            fuzzy = true,
            smartcase = true,
            ignorecase = true,
            sort_empty = false,
            filename_bonus = true,
            file_pos = true,
            cwd_bonus = true,
            frecency = true,
            history_bonus = true,
          },
          layouts = {
            telescope = {
              -- Copy from https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#telescope
              reverse = false,
              layout = {
                box = "horizontal",
                backdrop = false,
                height = 0.9,
                width = 0.9,
                border = "rounded",
                {
                  box = "vertical",
                  {
                    win = "input",
                    height = 1,
                    border = "none",
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                  },
                  { win = "list", title = " Results ", title_pos = "center", border = "none" },
                },
                {
                  win = "preview",
                  title = "{preview:Preview}",
                  width = 0.60,
                  border = "none",
                  title_pos = "center",
                },
              },
            },
          },
          sources = {
            files = {},
            explorer = { layout = { layout = { position = "right" } } },
            lines = {
              layout = {
                preset = function()
                  return "telescope"
                end,
              },
            },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<a-c>"] = {
              "toggle_cwd",
              mode = { "n", "i" },
            },
          },
        },
      },
      actions = {
        ---@param p snacks.Picker
        toggle_cwd = function(p)
          local function get_git_root()
            local path = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
            return vim.fs.normalize(path or vim.loop.cwd())
          end
          local root = get_git_root()
          local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
          local current = p:cwd()
          -- p:set_cwd(current == root and cwd or root)
          p:set_cwd(root)
          p:find()
        end,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader><space>", require("snacks").picker.smart, desc = "Smart Find Files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep"},
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
    { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
    { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
    { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
    { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- git
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
    { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
    -- ui
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
     {
                "<leader>ft",
                function()
                    Snacks.picker.treesitter {
                        finder = "treesitter_symbols",
                        format = "lsp_symbol",
                        tree = true,
                        filter = {
                            default = {
                                "Class",
                                "Enum",
                                "Field",
                                "Function",
                                "Method",
                                "Module",
                                "Namespace",
                                "Struct",
                                "Trait",
                            },
                            markdown = true,
                            help = true,
                        },
                    }
                end,
                desc = "[t]reesitter picker",
            },
            {
                "<leader>n",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "Notification History",
            },
            {
                "<leader>fe",
                function()
                    Snacks.explorer()
                end,
                desc = "File Explorer",
            },
    specs = {
            "folke/snacks.nvim",
            opts = function(_, opts)
                return vim.tbl_deep_extend("force", opts or {}, {
                    picker = {
                        actions = require("trouble.sources.snacks").actions,
                        win = {
                            input = {
                                keys = {
                                    ["<c-t>"] = {
                                        "trouble_open",
                                        mode = { "n", "i" },
                                    },
                                },
                            },
                        },
                    },
                })
            end,
        },
  },
}
