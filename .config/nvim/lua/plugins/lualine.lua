return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local colors = {
      blue = "#89b4fa",
      teal = "#94e2d5",
      green = "#a6e3a1",
      yellow = "#f9e2af",
      peach = "#fab387",
      red = "#f38ba8",
      mauve = "#cba6f7",
      surface0 = "#313244",
      base = "#1e1e2e",
    }
    local theme = {
      normal = {
        a = { fg = colors.base, bg = colors.blue, gui = "bold" },
        b = { fg = colors.base, bg = colors.teal },
        c = { fg = colors.base, bg = colors.green },
      },
      insert = {
        a = { fg = colors.base, bg = colors.mauve, gui = "bold" },
        b = { fg = colors.base, bg = colors.peach },
        c = { fg = colors.base, bg = colors.yellow },
      },
      visual = {
        a = { fg = colors.base, bg = colors.red, gui = "bold" },
        b = { fg = colors.base, bg = colors.teal },
        c = { fg = colors.base, bg = colors.surface0 },
      },
      replace = {
        a = { fg = colors.base, bg = colors.yellow, gui = "bold" },
        b = { fg = colors.base, bg = colors.red },
        c = { fg = colors.base, bg = colors.surface0 },
      },
      inactive = {
        a = { fg = colors.base, bg = colors.surface0 },
        b = { fg = colors.base, bg = colors.surface0 },
        c = { fg = colors.base, bg = colors.surface0 },
      },
    }
    return {
      options = {
        theme = "catppuccin",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
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
        lualine_x = { "filetype", "tabs", "coedium" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    }
  end,
}
