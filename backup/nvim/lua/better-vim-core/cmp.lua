local cmp = require "cmp"
local luasnip = require "luasnip"
local helpers = require "better-vim-core.helpers"

local function should_load_snippets()
  local unload_plugins_table = helpers.get_config_item { "unload_plugins" }

  for _, k in pairs(unload_plugins_table) do
    if k == "snippets" then
      return false
    end
  end

  return true
end

if should_load_snippets() then
  require("luasnip.loaders.from_vscode").lazy_load()
end

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete {},
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    {
      name = "nvim_lsp",
      entry_filter = function(entry)
        if should_load_snippets() then
          return entry:get_kind()
        end

        return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      end,
    },
    { name = "luasnip" },
  },
}
