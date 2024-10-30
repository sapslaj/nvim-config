local Util = require("util")

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        -- lua = { "luacheck" },
        markdown = { "vale" },
        puppet = { "puppet-lint" },
        sh = { "shellcheck" },
      },
      linters = {
        ["puppet-lint"] = {
          args = {
            "--no-autoloader_layout-check",
            "--no-documentation-check",
            "--log-format",
            "%{path}:%{line}:%{column}:%{kind}:%{check}:%{message}",
          },
        },
      },
    },
    config = function(_, opts)
      local lint = require("lint")

      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = Util.debounce(100, function(ev)
          for _, exclude in pairs({
            "%.env$",
            "%.env%..$",
            "%.secrets$",
          }) do
            if ev.file:match(exclude) then
              return
            end
          end
          lint.try_lint()
        end),
      })
    end,
  },
}
