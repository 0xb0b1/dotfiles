--  NOTE: Esse módulo é um complemento ao `helpers`.
--  No entanto, ele pode ser importado pela config do user
--  já que o módulo helpers não pode ser importado, pois
--  gera um loop de imports e crasha o Neovim.
local M = {}

M.statusline = {}

M.statusline.get_file_name = function()
  if vim.bo.filetype == "NvimTree" then
    return "  Explorer"
  else
    return " " .. vim.fn.expand "%:t"
  end
end

M.load_theme = function(table)
  table.lazy = false
  table.priority = 1000
  return table
end

return M
