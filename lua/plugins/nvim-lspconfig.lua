local Util = require("util")
local Lsp = require("util.lsp")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
      {
        "williamboman/mason-lspconfig.nvim",
      },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = false,
      },
      document_highlight = {
        enabled = true,
      },
      -- stylua: ignore
      keys = {
        { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
        { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
        { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
        { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
        { "K", vim.lsp.buf.hover, desc = "Hover" },
        { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
        { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
        { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
        { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
        { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
      },
    },
    config = function(_, opts)
      Lsp.on_attach(function(client, buffer)
        local Keys = require("lazy.core.handler.keys")
        for _, keymap in pairs(opts.keys) do
          local opts = Keys.opts(keymap)
          keymap.lhs = keymap.lhs or keymap[1]
          keymap.rhs = keymap.rhs or keymap[2]
          opts.cond = nil
          opts.has = nil
          opts.silent = opts.silent ~= false
          opts.buffer = buffer
          vim.keymap.set(keymap.mode or "n", keymap.lhs, keymap.rhs, opts)
        end
      end)
      if opts.inlay_hints.enabled then
        Lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            Util.toggle.inlay_hints(buffer, true)
          end
        end)
      end
      if opts.codelens.enabled and vim.lsp.codelens then
        Lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = require("lazyvim.config").icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    end,
    legendary = {
      commands = {
        {
          ":LspLog",
          description = "Show language server log",
        },
        {
          ":LspInfo",
          description = "Show status of active and configured language servers",
        },
        {
          ":LspStart",
          description = "Start all language servers matching the current buffer type",
        },
        {
          ":LspStart [config_name]",
          description = "Start the requested server name",
          unfinished = true,
        },
        {
          ":LspStop",
          description = "Stop all buffer clients",
        },
        {
          ":LspRestart",
          description = "Restart all buffer clients",
        },
      },
    },
  },
}
