return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      settings = {
        search = {
          anaconda_base = {
            command = "fd python$ ~/anaconda3/bin --full-path --color never -E __pycache__",
            type = "anaconda",
          },
          anaconda_envs = {
            command = "fd python$ ~/anaconda3/envs --full-path --color never -E __pycache__",
            type = "anaconda",
          },
        },
      },
    },
    cmd = { "VenvSelect", "VenvSelectCached" },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python virtualenv", ft = "python" },
    },
  },
}
