local Util = require("util")

return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        ["terraform-vars"] = { "terraform_fmt" },
        go = { "gofmt", "gci" },
        javascript = { "prettier" },
        lua = { "stylua" },
        markdown = { "mdformat" },
        puppet = { "puppet-lint" },
        python = { "ruff_format", "ruff_fix" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        typescript = { { "dprint", "prettier" } },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    legendary = {
      commands = {
        {
          ":ConformInfo",
          description = "Show configured and available formatters",
        },
      },
    },
  },
}
