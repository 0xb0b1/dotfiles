return {
  "IogaMaster/neocord",
  opts = {
    workspace_text = function()
      -- Get the Git branch name
      local function get_git_branch()
        local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
        if handle then
          local branch = handle:read("*l")
          handle:close()
          if branch and branch ~= "" then
            return branch
          end
        end
        return nil
      end

      -- Get the current folder (project) name
      local function get_project_name()
        local cwd = vim.fn.getcwd()
        return vim.fn.fnamemodify(cwd, ":t") -- Take tail of path
      end

      local project = get_project_name()
      local branch = get_git_branch()

      if branch then
        return string.format("%s (%s)", project, branch)
      else
        return project
      end
    end,
  },
}
