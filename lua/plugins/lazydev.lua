return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "lazy" } },
      },
    },
    legendary = {
      commands = {
        {
          ":LazyDev debug",
          description = "Show notification with the lazydev settings for the current buffer",
        },
        {
          ":LazyDev lsp",
          description = "Show notification with the settings for any attached LSP server",
        },
      },
    },
  },
}
