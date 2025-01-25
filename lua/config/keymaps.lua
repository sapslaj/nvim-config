local Terminal  = require('toggleterm.terminal').Terminal
local Legendary = require("legendary")
local WhichKey = require("which-key")

local function g(lhs, name, opts)
  WhichKey.register({ [lhs] = name }, opts)
end

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

-- disable F1 help
vim.keymap.set({"n", "x", "i"}, "<F1>", "<nop>")

-- which-key groups
g("g", "goto")
g("gs", "surround")
g("]", "next")
g("[", "prev")
g("<leader><tab>", "tabs")
g("<leader>b", "buffer")
g("<leader>c", "code")
g("<leader>cs", "sort")
g("<leader>csu", "sort/uniq")
g("<leader>f", "file/find")
g("<leader>g", "git")
g("<leader>gh", "hunks")
g("<leader>q", "quit/session")
g("<leader>n", "noice")
g("<leader>s", "search")
g("<leader>u", "ui/editor")
g("<leader>w", "windows")
g("<leader>x", "diagnostics/quickfix")

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
m("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
m("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
m("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
m("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Move Lines
m("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
m("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
m("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
m("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
m("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
m("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
m("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
m("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
m("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
m("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
m("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
m("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
m({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
m(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- better indenting
m("v", "<", "<gv")
m("v", ">", ">gv")

-- new file
m("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

m("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
m("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

m("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
m("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
m({ "n", "v" }, "<leader>cf", function()
  require("conform").format({
    -- lsp_fallback = true,
  })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
m("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
m("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
m("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
m("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
m("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
m("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
m("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- quit
m("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

m("n", "<C-/>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
m("n", "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })

-- Terminal Mappings
m("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
m("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
m("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
m("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
m("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
m("t", "<C-/>", "<cmd>ToggleTerm<cr>", { desc = "Hide Terminal" })
m("t", "<c-_>", "<cmd>ToggleTerm<cr>", { desc = "which_key_ignore" })

-- windows
m("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
m("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
m("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
m("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
m("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
m("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- tabs
m("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
m("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
m("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
m("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
m("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
m("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
m("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Legendary
m("n", "<leader>l", ":Legendary<cr>", { desc = "Legendary" })

-- sorting
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

-- git
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
})

m("n", "<leader>gg", function()
  lazygit:toggle()
end, { desc = "Lazygit" })

m("n", "<leader>ga", "<cmd>Git add --all<CR>", { desc = "git add --all" })
m("n", "<leader>gc", "<cmd>Git commit -v<CR>", { desc = "git commit" })
m("n", "<leader>gs", "<cmd>Git<CR>", { desc = "git status/summary" })
m("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "git blame" })
m("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph<CR>", { desc = "git log" })
m("n", "<leader>gL", "<cmd>Telescope git_commits<CR>", { desc = "git log (Telescope)" })
