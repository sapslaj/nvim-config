local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- We need certain options loaded as early as possible so keymaps and
-- some plugins are configured correctly.
require("config.options")

require("lazy").setup({
  {
    import = "plugins",
  },
}, {
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    missing = true,
  },
  ui = {
    backdrop = 100,
  },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    enabled = false,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("config.autocmds")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Load keymaps after plugins are loaded.
    require("config.keymaps")

    local health = require("lazy.health")
    vim.list_extend(health.valid, {
      "legendary",
    })
  end,
})

vim.cmd.colorscheme("catppuccin")
