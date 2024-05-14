return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      if require("lazyvim.util").has("noice.nvim") then
        opts.defaults["<leader>n"] = { name = "+noice" }
      end
      opts.defaults["<leader>cs"] = { name = "+sort" }
      opts.defaults["<leader>csu"] = { name = "+sort/uniq" }
      opts.defaults["<leader>u"] = { name = "+ui/editor" }
    end,
  },
}
