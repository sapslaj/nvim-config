return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
    },
    config = function(config)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      npairs.setup(config)

      -- placeholder for custom rules
      -- npairs.add_rules({
      --   Rule("'")
      -- })
    end,
    keys = {
      {
        "<leader>up",
        function()
          local npairs = require("nvim-autopairs")
          npairs.toggle()
          if npairs.state.disabled then
            vim.notify("Disabled auto pairs", "info")
          else
            vim.notify("Enabled auto pairs", "info")
          end
        end,
      },
    },
    legendary = {
      funcs = {
        {
          function()
            local npairs = require("nvim-autopairs")
            npairs.toggle()
            if npairs.state.disabled then
              vim.notify("Disabled auto pairs", "info")
            else
              vim.notify("Enabled auto pairs", "info")
            end
          end,
          description = "autopairs - toggle",
        },
      },
    },
  },
}
