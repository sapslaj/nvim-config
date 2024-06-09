return {
  {
    "bfredl/nvim-luadev",
    legendary = {
      funcs = {
        {
          function()
            require('luadev').exec(vim.api.nvim_get_current_line())
          end,
          description = "LuaDev-Run",
        },
      },
    },
  },
}
