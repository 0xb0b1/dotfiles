return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          args = { "-v", "-race", "-count=1", "-timeout=60s" },
          experimental = {
            test_table = true,
          },
        },
        ["neotest-python"] = {
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        },
        ["neotest-jest"] = {},
        ["neotest-vitest"] = {},
      },
    },
  },
}
