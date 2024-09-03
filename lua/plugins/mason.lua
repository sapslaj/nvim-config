return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = function()
      local function has(...)
        return vim.fn.executable(...) == 1
      end
      local ensure_installed = {
        "lua-language-server",
      }
      if has("clang") then
        table.insert(ensure_installed, "clang")
      end
      if has("elixir") then
        table.insert(ensure_installed, "elixir-ls")
      end
      if has("go") then
        table.insert(ensure_installed, "gofumpt")
        table.insert(ensure_installed, "goimports")
        table.insert(ensure_installed, "gopls")
      end
      if has("helm") then
        table.insert(ensure_installed, "helm-ls")
      end
      if has("javac") then
        table.insert(ensure_installed, "java-debug-adapter")
        table.insert(ensure_installed, "java-test")
      end
      if has("npm") then
        table.insert(ensure_installed, "json-lsp")
        table.insert(ensure_installed, "vtsls")
      end
      if has("pip") then
        table.insert(ensure_installed, "basedpyright")
      end

      return {
        ensure_installed = ensure_installed,
      }
    end,
    legendary = {
      commands = {
        {
          ":Mason",
          description = "Mason - open a graphical status window",
        },
        {
          ":MasonUpdate",
          description = "Mason - update all managed registries",
        },
        {
          ":MasonInstall <package> ...",
          description = "Mason - installs/re-installs the provided packages",
          unfinshed = true,
        },
        {
          ":MasonUninstall <package> ...",
          description = "Mason - uninstalls the provided packages",
          unfinshed = true,
        },
        {
          ":MasonUninstallAll",
          description = "Mason - uninstalls all packages",
        },
        {
          ":MasonLog",
          description = "Mason - opens the mason.nvim log file in a new tab window",
        },
      },
    },
  },
}
