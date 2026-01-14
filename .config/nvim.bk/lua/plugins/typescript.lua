return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Add TypeScript-specific utilities
      opts.servers = opts.servers or {}
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
        settings = {
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            preferences = {
              importModuleSpecifier = "relative",
              importModuleSpecifierEnding = "auto",
            },
          },
          javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            preferences = {
              importModuleSpecifier = "relative",
              importModuleSpecifierEnding = "auto",
            },
          },
        },
      })
      return opts
    end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = function()
      require("tsc").setup()
    end,
  },
}
