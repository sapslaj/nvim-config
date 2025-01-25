return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      extensions = { "neo-tree", "lazy" },
      sections = {
        lualine_a = {
          function()
            local mode = require("lualine.utils.mode").get_mode()
            return vim.b["visual_multi"] and mode .. " - MULTI" or mode
          end,
        },
        lualine_b = {
          "branch",
        },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            path = 1,
            symbols = {
              modified = "  ",
              readonly = "",
              unnamed = "",
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
          },
        },
        lualine_y = {
          {
            function()
              return vim.o.filetype
            end,
          },
          {
            "encoding",
            show_bomb = true,
          },
          {
            "diff",
          },
        },
        lualine_z = {
          { "location", padding = { left = 0, right = 1 } },
          { "progress", separator = "", padding = { left = 1, right = 0 } },
        },
      },
    },
  },
}
