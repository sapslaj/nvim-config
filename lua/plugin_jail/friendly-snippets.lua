return {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip").cleanup()
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "global" },
      })
    end,
  },
}
