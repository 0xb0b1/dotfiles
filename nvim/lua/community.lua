if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.nord-nvim" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.tokyodark-nvim" },
  { import = "astrocommunity.bars-and-lines.lualine.nvim" },
  { import = "astrocommunity.bars-and-lines.scope.nvim" },
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.media.presence-nvim" },
  { import = "astrocommunity.media.pets-nvim" },
  { import = "astrocommunity.completion.cmp-nvim-lua" },
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.pack.clojure" },
  { import = "astrocommunity.code-runner.conjure" },
  { import = "astrocommunity.editing-support.nvim-parinfer" },
  { import = "astrocommunity.editing-support.nvim-treesitter-sexp" },
  { import = "astrocommunity.comment.ts-comments-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.recipes.disable-tabline" },
  { import = "astrocommunity.recipes.neovide" },
}
