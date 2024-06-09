return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip").cleanup()
          require("luasnip.loaders.from_vscode").lazy_load({
            exclude = { "global" },
          })
        end,
      },
    },
    keys = function()
      return {}
    end,
  },
}
