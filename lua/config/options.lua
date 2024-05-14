-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.list = true
--vim.opt.listchars:append("eol:↵")
vim.opt.listchars:append("space:·")
vim.opt.listchars:append("nbsp:·")
vim.opt.listchars:append("tab:→ ")
vim.opt.listchars:append("trail:␣")
vim.opt.listchars:append("precedes:«")
vim.opt.listchars:append("extends:»")

vim.opt.conceallevel = 0
vim.opt.clipboard = ""

vim.g.autoformat = false
vim.g.skip_ts_context_commentstring_module = true
vim.g.formatoptions = "jcroqlnt"
