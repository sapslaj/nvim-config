local Util = require("util")

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      winopts = {
        backdrop = 100,
      },
    },
    -- init = function()
    --   Util.on_very_lazy(function()
    --     vim.ui.select = function(...)
    --       require("lazy").load({ plugins = { "fzf-lua" } })
    --       local opts = Util.opts("fzf-lua") or {}
    --       require("fzf-lua").register_ui_select(opts.ui_select or nil)
    --       return vim.ui.select(...)
    --     end
    --   end)
    -- end,
  },
}
