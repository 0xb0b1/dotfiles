-- FILE: ~/.config/nvim/lua/plugins/harpoon-autoadd.lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    local list = harpoon:list()

    local function is_already_added(path)
      for _, item in ipairs(list.items) do
        if item.value == path then
          return true
        end
      end
      return false
    end

    vim.api.nvim_create_autocmd("BufReadPost", {
      callback = function(args)
        local filepath = vim.api.nvim_buf_get_name(args.buf)
        if vim.fn.filereadable(filepath) == 1 and not is_already_added(filepath) then
          list:add(filepath)
        end
      end,
    })
  end,
}
