return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["terraform-vars"] = { "terraform_fmt" },
        go = { "gofmt", "gci" },
        javascript = { "prettier" },
        python = { "ruff_format", "ruff_fix" },
        puppet = { "puppet-lint" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        typescript = { "prettier" },
      },
    },
  },
}
