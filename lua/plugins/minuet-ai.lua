return {
  {
    "milanglacier/minuet-ai.nvim",
    enabled = os.getenv("NVIM_ENABLE_MINUET") == "true",
    config = function()
      require("minuet").setup {
        lsp = {
          enabled_ft = { "*" },
        },
        provider = os.getenv("NVIM_MINUET_PROVIDER"),
        context_window = 512,
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
          openai_fim_compatible = {
            api_key = "LLAMA_API_KEY",
            name = "Llama.cpp",
            end_point = "https://minuet.sapslaj.xyz/v1/completions",
            -- The model is set by the llama-cpp server and cannot be altered
            -- post-launch.
            model = "PLACEHOLDER",
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
            -- Llama.cpp does not support the `suffix` option in FIM completion.
            -- Therefore, we must disable it and manually populate the special
            -- tokens required for FIM completion.
            template = {
              prompt = function(context_before_cursor, context_after_cursor, _)
                return "<|fim_prefix|>"
                  .. context_before_cursor
                  .. "<|fim_suffix|>"
                  .. context_after_cursor
                  .. "<|fim_middle|>"
              end,
              suffix = false,
            },
          },
        }
      }
    end,
  },
}
