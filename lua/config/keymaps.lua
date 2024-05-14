-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local Legendary = require("legendary")

local function m(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false
  local keymap = {
    lhs,
    rhs,
    mode = mode,
    description = opts.desc,
  }
  -- vim.keymap.set(mode, lhs, rhs, opts)
  Legendary.keymap(keymap)
end

m("n", "<leader>gG", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (root dir)" })
m("n", "<leader>gg", function()
  Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })
m("n", "<leader>ft", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })
m("n", "<leader>fT", function()
  Util.terminal(nil, { cwd = Util.root() })
end, { desc = "Terminal (root dir)" })
m("n", "<c-/>", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })
-- vim.keymap.set("n", "<c-/>", function()
--   Util.float_term()
-- end, { desc = "Terminal (cwd)" })

m("n", "<leader>l", ":Legendary<cr>", { desc = "Legendary" })

m("x", "<leader>css", ":'<,'>sort<cr>", { silent = true, desc = "Sort Lines Ascending" })
m("x", "<leader>csS", ":'<,'>sort!<cr>", { silent = true, desc = "Sort Lines Descending" })
m("x", "<leader>csn", ":'<,'>sort n<cr>", { silent = true, desc = "Sort Lines (numeric) Ascending" })
m("x", "<leader>csN", ":'<,'>sort! n<cr>", { silent = true, desc = "Sort Lines (numeric) Descending" })
m("x", "<leader>csf", ":'<,'>sort f<cr>", { silent = true, desc = "Sort Lines (float) Ascending" })
m("x", "<leader>csF", ":'<,'>sort! f<cr>", { silent = true, desc = "Sort Lines (float) Descending" })
m("x", "<leader>csx", ":'<,'>sort x<cr>", { silent = true, desc = "Sort Lines (hex) Ascending" })
m("x", "<leader>csX", ":'<,'>sort! x<cr>", { silent = true, desc = "Sort Lines (hex) Descending" })
m("x", "<leader>csb", ":'<,'>sort b<cr>", { silent = true, desc = "Sort Lines (binary) Ascending" })
m("x", "<leader>csB", ":'<,'>sort! b<cr>", { silent = true, desc = "Sort Lines (binary) Descending" })

m("x", "<leader>csus", ":'<,'>sort u<cr>", { silent = true, desc = "Sort Unique Lines Ascending" })
m("x", "<leader>csuS", ":'<,'>sort! u<cr>", { silent = true, desc = "Sort Unique Lines Descending" })
m("x", "<leader>csun", ":'<,'>sort un<cr>", { silent = true, desc = "Sort Unique Lines (numeric) Ascending" })
m("x", "<leader>csuN", ":'<,'>sort! un<cr>", { silent = true, desc = "Sort Unique Lines (numeric) Descending" })
m("x", "<leader>csuf", ":'<,'>sort uf<cr>", { silent = true, desc = "Sort Unique Lines (float) Ascending" })
m("x", "<leader>csuF", ":'<,'>sort! uf<cr>", { silent = true, desc = "Sort Unique Lines (float) Descending" })
m("x", "<leader>csux", ":'<,'>sort ux<cr>", { silent = true, desc = "Sort Unique Lines (hex) Ascending" })
m("x", "<leader>csuX", ":'<,'>sort! ux<cr>", { silent = true, desc = "Sort Unique Lines (hex) Descending" })
m("x", "<leader>csub", ":'<,'>sort ub<cr>", { silent = true, desc = "Sort Unique Lines (binary) Ascending" })
m("x", "<leader>csuB", ":'<,'>sort! ub<cr>", { silent = true, desc = "Sort Unique Lines (binary) Descending" })

m("n", "<leader>ga", "<cmd>Git add --all<CR>", { desc = "git add --all" })
m("n", "<leader>gc", "<cmd>Git commit -v<CR>", { desc = "git commit" })
m("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph<CR>", { desc = "git log" })
m("n", "<leader>gL", "<cmd>Telescope git_commits<CR>", { desc = "git log (Telescope)" })
