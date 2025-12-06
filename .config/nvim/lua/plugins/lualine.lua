return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = "catppuccin",
        -- component_separators = { left = "", right = "" },
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "branch" },
        lualine_c = {
          {
            function()
              local cwd = vim.fn.getcwd(0, 0)
              local shortened = vim.fn.fnamemodify(cwd, ":t")
              return "󰉋 " .. shortened -- folder icon + dir name
            end,
            icon = "",
            padding = { left = 1, right = 1 },
          },
          {
            "filename",
            path = 1, -- 0 = filename only, 1 = relative path, 2 = absolute path
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
            fmt = function(str)
              local parent_dir = vim.fn.fnamemodify(str, ":h")
              local filename = vim.fn.fnamemodify(str, ":t")
              return parent_dir .. "/" .. filename
            end,
          },
        },
        lualine_x = { "filetype", "tabs", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {},
    }
  end,
}
