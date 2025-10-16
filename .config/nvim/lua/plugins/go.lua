return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Auto format on save
        lsp_cfg = false, -- Use nvim-lspconfig settings instead
        lsp_gofumpt = true,
        lsp_keymaps = false, -- We have custom keymaps
        lsp_codelens = true,
        lsp_inlay_hints = {
          enable = true,
          style = "inlay",
        },
        -- Diagnostic config
        diagnostic = {
          hdlr = true,
          underline = true,
          virtual_text = { spacing = 0, prefix = "■" },
          signs = true,
          update_in_insert = false,
        },
        -- Test config
        test_runner = "go", -- or 'richgo', 'dlv'
        run_in_floaterm = false,
        -- DAP config
        dap_debug = true,
        dap_debug_gui = true,
        dap_debug_keymap = false, -- We have custom keymaps
        -- Other features
        trouble = true, -- Enable trouble integration
        luasnip = false, -- Disable to avoid ts_utils dependency issue
      })

      -- Auto commands for Go files
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
