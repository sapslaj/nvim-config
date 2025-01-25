local Util = require("util")

vim.g.lint_enabled = true

function try_lint(filename)
  if not vim.g.lint_enabled then
    return
  end

  local lint = require("lint")

  if not filename then
    lint.try_lint()
    return
  end

  for _, exclude in pairs({
    "%.env$",
    "%.env%..$",
    "%.secrets$",
  }) do
    if filename:match(exclude) then
      return
    end
  end
  lint.try_lint()
end

function lint_toggle()
  if vim.g.lint_enabled then
    vim.g.lint_enabled = false
    vim.notify("Disabled lint", "info")
  else
    vim.g.lint_enabled = true
    vim.notify("Enabled lint", "info")
  end
end

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
          try_lint(ev.file)
        end),
      })
    end,
    legendary = {
      funcs = {
        {
          function()
            lint_toggle()
          end,
          description = "lint - toggle"
        },
        {
          function()
            vim.g.lint_enabled = true
            try_lint()
          end,
          description = "lint - enable"
        },
        {
          function()
            vim.g.lint_enabled = false
          end,
          description = "lint - disable"
        },
        {
          function()
            try_lint()
          end,
          description = "lint - run linting"
        },
      },
    },
  },
}
