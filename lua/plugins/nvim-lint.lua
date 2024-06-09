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
        callback = Util.debounce(100, function()
          -- Use nvim-lint's logic first:
          -- * checks if linters exist for the full filetype first
          -- * otherwise will split filetype by "." and add all those linters
          -- * this differs from conform.nvim which only uses the first filetype that has a formatter
          local names = lint._resolve_linter_by_ft(vim.bo.filetype)

          -- Create a copy of the names table to avoid modifying the original.
          names = vim.list_extend({}, names)

          -- Add fallback linters.
          if #names == 0 then
            vim.list_extend(names, lint.linters_by_ft["_"] or {})
          end

          -- Add global linters.
          vim.list_extend(names, lint.linters_by_ft["*"] or {})

          -- Filter out linters that don't exist or don't match the condition.
          local ctx = { filename = vim.api.nvim_buf_get_name(0) }
          ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
          names = vim.tbl_filter(function(name)
            local linter = lint.linters[name]
            if not linter then
              vim.notify("Linter not found: " .. name, "warning")
            end
            return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
          end, names)

          -- Run linters.
          if #names > 0 then
            lint.try_lint(names)
          end
        end),
      })
    end,
  },
}
