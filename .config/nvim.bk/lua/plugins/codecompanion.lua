return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
        agent = {
          adapter = "anthropic",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY",
            },
            schema = {
              model = {
                default = "claude-4-sonnet-20250514", -- Claude Sonnet 4
                choices = {
                  "claude-4-sonnet-20250514", -- Claude Sonnet 4 (recommended for daily use)
                  "claude-4-opus-20250514", -- Claude Opus 4 (most capable)
                  "claude-3-5-sonnet-20241022", -- Fallback to Claude 3.5
                  "claude-3-5-haiku-20241022", -- Fast fallback
                },
              },
              max_tokens = {
                default = 8192, -- Claude 4 supports higher token limits
              },
              temperature = {
                default = 0.1,
              },
            },
          })
        end,
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            width = 0.45,
            height = 0.8,
            relative = "editor",
            border = "single",
            title = "Claude 4 Chat",
          },
          intro_message = "Welcome! I'm Claude 4, ready to help with your Go backend development.",
        },
      },
      opts = {
        log_level = "ERROR",
        send_code = true,
        use_default_actions = true,
        use_default_prompts = true,
      },
      prompt_library = {
        ["Go Architecture Review"] = {
          strategy = "chat",
          description = "Comprehensive Go architecture analysis with Claude 4",
          opts = {
            mapping = "<Leader>gar",
            modes = { "v" },
            slash_cmd = "arch",
            auto_submit = true,
          },
          prompts = {
            {
              role = "user",
              content = function()
                return "As Claude 4, please provide a comprehensive architecture review of this Go code:\n\n"
                  .. "Analyze:\n"
                  .. "- Overall design patterns and architectural decisions\n"
                  .. "- Scalability and performance implications\n"
                  .. "- Error handling and resilience patterns\n"
                  .. "- Testability and maintainability\n"
                  .. "- Security considerations\n"
                  .. "- Suggested improvements with rationale\n\n"
                  .. "Code:\n```go\n"
                  .. require("codecompanion.helpers.actions").get_code()
                  .. "\n```"
              end,
            },
          },
        },
        ["Advanced Go Optimization"] = {
          strategy = "chat",
          description = "Deep performance optimization analysis",
          opts = {
            mapping = "<Leader>gopt",
            modes = { "v" },
            slash_cmd = "optimize",
          },
          prompts = {
            {
              role = "user",
              content = function()
                return "Using Claude 4's advanced reasoning, analyze this Go code for performance optimizations:\n\n"
                  .. "Focus on:\n"
                  .. "- Memory allocation patterns and potential leaks\n"
                  .. "- Goroutine usage and concurrency optimizations\n"
                  .. "- Algorithm complexity improvements\n"
                  .. "- I/O and database query optimizations\n"
                  .. "- Compiler optimizations and build tags\n"
                  .. "- Benchmarking suggestions\n\n"
                  .. "Provide specific, actionable recommendations with code examples.\n\n"
                  .. "Code:\n```go\n"
                  .. require("codecompanion.helpers.actions").get_code()
                  .. "\n```"
              end,
            },
          },
        },
      },
    })
  end,
}
