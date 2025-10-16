return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Enhanced Python setup
      opts.servers = opts.servers or {}
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
      return opts
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      anaconda_base_path = "~/anaconda3",
      anaconda_envs_path = "~/anaconda3/envs",
    },
    cmd = { "VenvSelect", "VenvSelectCached" },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python virtualenv", ft = "python" },
    },
  },
}
