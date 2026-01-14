-- Docker-aware linting/formatting via none-ls
-- Runs linters inside Docker containers when a .docker-dev.lua config exists

local M = {}

-- Helper: Check if file exists
local function file_exists(path)
  return vim.fn.filereadable(path) == 1
end

-- Helper: Find project root (look for docker-compose.yml, Dockerfile, or .git)
local function find_project_root()
  local markers = { "docker-compose.yml", "docker-compose.yaml", "Dockerfile", ".git" }
  local path = vim.fn.expand("%:p:h")
  while path ~= "/" do
    for _, marker in ipairs(markers) do
      if file_exists(path .. "/" .. marker) then
        return path
      end
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return nil
end

-- Load project-specific docker config from .docker-dev.lua
-- Expected format:
-- return {
--   container = "my_container_name",  -- or service name for docker-compose
--   use_compose = true,               -- use docker-compose exec instead of docker exec
--   workdir = "/app",                 -- working directory inside container
--   python = true,                    -- enable python linters
--   node = true,                      -- enable node/ts linters
--   go = true,                        -- enable go linters
-- }
function M.load_docker_config()
  local root = find_project_root()
  if not root then
    return nil
  end

  local config_path = root .. "/.docker-dev.lua"
  if not file_exists(config_path) then
    return nil
  end

  local ok, config = pcall(dofile, config_path)
  if ok and type(config) == "table" then
    config._root = root
    return config
  end
  return nil
end

-- Build docker exec command
function M.docker_cmd(config, cmd, args)
  local docker_args = {}

  if config.use_compose then
    table.insert(docker_args, "docker-compose")
    table.insert(docker_args, "exec")
    table.insert(docker_args, "-T") -- Disable pseudo-TTY
    if config.workdir then
      table.insert(docker_args, "-w")
      table.insert(docker_args, config.workdir)
    end
    table.insert(docker_args, config.container)
  else
    table.insert(docker_args, "docker")
    table.insert(docker_args, "exec")
    if config.workdir then
      table.insert(docker_args, "-w")
      table.insert(docker_args, config.workdir)
    end
    table.insert(docker_args, config.container)
  end

  table.insert(docker_args, cmd)
  for _, arg in ipairs(args or {}) do
    table.insert(docker_args, arg)
  end

  return docker_args
end

return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require("null-ls")
    local docker_config = M.load_docker_config()

    opts.sources = opts.sources or {}

    -- If no docker config, use defaults (host-based linting)
    if not docker_config then
      return opts
    end

    vim.notify("Docker dev mode: " .. docker_config.container, vim.log.levels.INFO)

    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    -- Python: ruff (fast linter + formatter)
    if docker_config.python then
      -- Ruff linting via docker
      table.insert(
        opts.sources,
        diagnostics.ruff.with({
          command = docker_config.use_compose and "docker-compose" or "docker",
          args = function(params)
            local base_args = docker_config.use_compose
                and { "exec", "-T", "-w", docker_config.workdir or "/app", docker_config.container }
              or { "exec", "-w", docker_config.workdir or "/app", docker_config.container }

            -- Add ruff command and args
            vim.list_extend(base_args, {
              "ruff",
              "check",
              "--stdin-filename",
              params.bufname,
              "-",
            })
            return base_args
          end,
        })
      )

      -- Ruff formatting via docker
      table.insert(
        opts.sources,
        formatting.ruff.with({
          command = docker_config.use_compose and "docker-compose" or "docker",
          args = function(params)
            local base_args = docker_config.use_compose
                and { "exec", "-T", "-w", docker_config.workdir or "/app", docker_config.container }
              or { "exec", "-w", docker_config.workdir or "/app", docker_config.container }

            vim.list_extend(base_args, {
              "ruff",
              "format",
              "--stdin-filename",
              params.bufname,
              "-",
            })
            return base_args
          end,
        })
      )

      -- Mypy via docker (optional, for type checking)
      table.insert(
        opts.sources,
        diagnostics.mypy.with({
          command = docker_config.use_compose and "docker-compose" or "docker",
          args = function(params)
            local base_args = docker_config.use_compose
                and { "exec", "-T", "-w", docker_config.workdir or "/app", docker_config.container }
              or { "exec", "-w", docker_config.workdir or "/app", docker_config.container }

            vim.list_extend(base_args, {
              "mypy",
              "--show-column-numbers",
              "--show-error-codes",
              "--no-error-summary",
              "--no-pretty",
              params.bufname,
            })
            return base_args
          end,
          -- Only run if mypy.ini or pyproject.toml exists
          condition = function(utils)
            return utils.root_has_file({ "mypy.ini", "pyproject.toml", "setup.cfg" })
          end,
        })
      )
    end

    -- Go: golangci-lint via docker
    if docker_config.go then
      table.insert(
        opts.sources,
        diagnostics.golangci_lint.with({
          command = docker_config.use_compose and "docker-compose" or "docker",
          args = function()
            local base_args = docker_config.use_compose
                and { "exec", "-T", "-w", docker_config.workdir or "/app", docker_config.container }
              or { "exec", "-w", docker_config.workdir or "/app", docker_config.container }

            vim.list_extend(base_args, {
              "golangci-lint",
              "run",
              "--out-format=json",
              "--allow-parallel-runners",
            })
            return base_args
          end,
        })
      )
    end

    -- TypeScript/JavaScript: ESLint via docker
    if docker_config.node then
      table.insert(
        opts.sources,
        diagnostics.eslint_d.with({
          command = docker_config.use_compose and "docker-compose" or "docker",
          args = function(params)
            local base_args = docker_config.use_compose
                and { "exec", "-T", "-w", docker_config.workdir or "/app", docker_config.container }
              or { "exec", "-w", docker_config.workdir or "/app", docker_config.container }

            vim.list_extend(base_args, {
              "npx",
              "eslint",
              "--format",
              "json",
              "--stdin",
              "--stdin-filename",
              params.bufname,
            })
            return base_args
          end,
        })
      )

      -- Prettier via docker
      table.insert(
        opts.sources,
        formatting.prettier.with({
          command = docker_config.use_compose and "docker-compose" or "docker",
          args = function(params)
            local base_args = docker_config.use_compose
                and { "exec", "-T", "-w", docker_config.workdir or "/app", docker_config.container }
              or { "exec", "-w", docker_config.workdir or "/app", docker_config.container }

            vim.list_extend(base_args, {
              "npx",
              "prettier",
              "--stdin-filepath",
              params.bufname,
            })
            return base_args
          end,
        })
      )
    end

    return opts
  end,
}
