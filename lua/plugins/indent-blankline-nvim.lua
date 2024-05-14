return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local highlight = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { bg = "#2f3236", blend = 50 })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { bg = "#26323a", blend = 50 })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { bg = "#2f2943", blend = 50 })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { bg = "#223142", blend = 50 })
      end)
      require("ibl").setup({
        indent = {
          -- char = "│",
          highlight = highlight,
          char = "",
        },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = {
          enabled = false,
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
