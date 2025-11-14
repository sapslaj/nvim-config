return {
  {
    "milanglacier/minuet-ai.nvim",
    enabled = os.getenv("NVIM_ENABLE_CLAUDE") == "true",
    config = function()
      require("minuet").setup {
        lsp = {
          enabled_ft = { "*" },
        },
        provider = "claude",
        provider_options = {
          claude = {
            -- max_tokens = 256,
            -- model = "claude-haiku-4.5",
            -- system = "see [Prompt] section for the default value",
            -- few_shots = "see [Prompt] section for the default value",
            -- chat_input = "See [Prompt Section for default value]",
            -- stream = true,
            -- api_key = "ANTHROPIC_API_KEY",
            -- end_point = "https://api.anthropic.com/v1/messages",
            optional = {
                -- pass any additional parameters you want to send to claude request,
                -- e.g.
                -- stop_sequences = nil,
            },
          },
        }
      }
    end,
  },
}
