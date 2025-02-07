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
        javascript = { "prettier", "dprint", stop_after_first = true },
        json = { "dprint" },
        lua = { "stylua" },
        markdown = { "dprint", "mdformat", stop_after_first = true },
        puppet = { "puppet-lint" },
        python = { "ruff_format", "ruff_fix" },
        rust = { "rustfmt" },
        terraform = { "terraform_fmt" },
        toml = { "dprint" },
        tf = { "terraform_fmt" },
        typescript = { "prettier", "dprint", stop_after_first = true },
        yaml = { "prettier", "dprint", stop_after_first = true },
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
