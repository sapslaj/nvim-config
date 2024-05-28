return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- lua = { "luacheck" },
        markdown = { "vale" },
        puppet = { "puppet-lint" },
        sh = { "shellcheck" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      lint.linters["puppet-lint"].args = {
        "--no-autoloader_layout-check",
        "--no-documentation-check",
        "--log-format",
        "%{path}:%{line}:%{column}:%{kind}:%{check}:%{message}",
      }
    end,
  },
}
