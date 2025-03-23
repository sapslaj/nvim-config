return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.7-sonnet-thought",
                choices = {
                  ["o3-mini-2025-01-31"] = {
                    opts = {
                      can_reason = true,
                    },
                  },
                  ["o1-2024-12-17"] = {
                    opts = {
                      can_reason = true,
                    },
                  },
                  ["o1-mini-2024-09-12"] = {
                    opts = {
                      can_reason = true,
                    },
                  },
                  "claude-3.7-sonnet",
                  "claude-3.5-sonnet",
                  "claude-3.7-sonnet-thought",
                  "gpt-4o-2024-08-06",
                  "gemini-2.0-flash-001",
                },
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
      display = {
        chat = {
          show_settings = true,
          auto_scroll = true,
        },
      },
    },
  },
}
