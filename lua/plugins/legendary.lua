return {
  {
    "mrjones2014/legendary.nvim",
    version = "v2.13.11",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
    opts = {
      extensions = {
        -- lazy_nvim = true,
        lazy_nvim_legendary = true,
        codecompanion = true,
        which_key = {
          auto_register = true,
        },
      },
    },
  },
}
