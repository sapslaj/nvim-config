return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    config = function()
      vim.g.VM_set_statusline = 0
      vim.g.VM_silent_exit = 1
      vim.g.VM_highlight_matches = "hi IncSearch cterm=underline"
      vim.g.VM_Maps = {}
      vim.g.VM_Maps["Find Under"] = "<C-d>"
      vim.g.VM_Maps["Find Subword Under"] = "<C-d>"
    end
  },
}
