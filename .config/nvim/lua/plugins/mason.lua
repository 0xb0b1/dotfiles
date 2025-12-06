-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "mason-org/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "pyright",
        "vtsls",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- Ensure additional tools are installed via Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "golangci-lint",
        "gofumpt",
        "goimports",
        "gomodifytags",
        "impl",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        "delve",
        "js-debug-adapter",
        -- add more arguments for adding more debuggers
      },
    },
  },
}
