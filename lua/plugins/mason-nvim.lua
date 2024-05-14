return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "dart-debug-adapter",
        "elixir-ls",
        "gofumpt",
        "goimports",
        "gopls",
        "java-debug-adapter",
        "java-test",
        "json-lsp",
        "lua-language-server",
        "pyright",
      },
    },
  },
}
