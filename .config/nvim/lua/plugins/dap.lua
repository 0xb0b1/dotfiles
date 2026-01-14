return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    config = function()
      local dap = require("dap")

      -- Go debugging
      require("dap-go").setup()

      -- Python debugging: try multiple common locations
      local python_path = nil
      local candidates = {
        vim.fn.expand("~/.virtualenvs/debugpy/bin/python"),
        vim.fn.exepath("python3"),
        vim.fn.exepath("python"),
      }
      for _, path in ipairs(candidates) do
        if vim.fn.executable(path) == 1 then
          python_path = path
          break
        end
      end
      if python_path then
        require("dap-python").setup(python_path)
      end

      -- TypeScript/JavaScript debugging
      local ok, registry = pcall(require, "mason-registry")
      if ok and registry then
        local pkg = registry.get_package("js-debug-adapter")
        if pkg and pkg:is_installed() then
          -- Mason v2 API: use get_install_path if available, fallback to install_dir
          local install_path = type(pkg.get_install_path) == "function" and pkg:get_install_path()
            or (pkg.install_dir and pkg.install_dir.path)
            or (vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter")

          local js_debug_path = install_path .. "/js-debug/src/dapDebugServer.js"

          -- Only configure if the debug server file exists
          if vim.fn.filereadable(js_debug_path) == 1 then
            dap.adapters["pwa-node"] = {
              type = "server",
              host = "localhost",
              port = "${port}",
              executable = {
                command = "node",
                args = { js_debug_path, "${port}" },
              },
            }

            for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
              dap.configurations[language] = {
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "Launch file",
                  program = "${file}",
                  cwd = "${workspaceFolder}",
                },
                {
                  type = "pwa-node",
                  request = "attach",
                  name = "Attach",
                  processId = require("dap.utils").pick_process,
                  cwd = "${workspaceFolder}",
                },
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "Debug Jest Tests",
                  runtimeExecutable = "node",
                  runtimeArgs = {
                    "./node_modules/jest/bin/jest.js",
                    "--runInBand",
                  },
                  rootPath = "${workspaceFolder}",
                  cwd = "${workspaceFolder}",
                  console = "integratedTerminal",
                  internalConsoleOptions = "neverOpen",
                },
              }
            end
          end
        end
      end
    end,
  },
}
