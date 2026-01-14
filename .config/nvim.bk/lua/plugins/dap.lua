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

      -- Python debugging
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

      -- TypeScript/JavaScript debugging
      local ok, registry = pcall(require, "mason-registry")
      if ok then
        local has_package, pkg = pcall(registry.get_package, "js-debug-adapter")
        if has_package and pkg:is_installed() then
          local js_debug_path = pkg:get_install_path() .. "/js-debug/src/dapDebugServer.js"

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
    end,
  },
}
