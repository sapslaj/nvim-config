local Legendary = require("legendary")
local Log = require("legendary.log")

return function()
  local has_lazy, _ = pcall(require, 'lazy')
  if not has_lazy then
    Log.warn("lazy.nvim integration is enabled, but cannot `require('lazy')`, aborting.")
    return
  end

  Legendary.commands({
    {
      ":Lazy",
      description = "Show plugin list",
    },
    {
      ":Lazy build <plugins>",
      description = "Rebuild a plugin",
      unfinished = true,
    },
    {
      ":Lazy check",
      description = "Check for updates and show the log",
    },
    {
      ":Lazy check [plugins]",
      description = "Check for updates and show the log",
      unfinished = true,
    },
    {
      ":Lazy clean",
      description = "Clean plugins that are no longer needed",
    },
    {
      ":Lazy clean [plugins]",
      description = "Clean plugins that are no longer needed",
      unfinished = true,
    },
    {
      ":Lazy clear",
      description = "Clear finished tasks",
    },
    {
      ":Lazy debug",
      description = "Show debug information",
    },
    {
      ":Lazy health",
      description = "Run :checkhealth lazy",
    },
    {
      ":Lazy home",
      description = "Show plugin list",
    },
    {
      ":Lazy help",
      description = "Show help",
    },
    {
      ":Lazy install",
      description = "Install missing plugins",
    },
    {
      ":Lazy install [plugins]",
      description = "Install missing plugins",
      unfinished = true,
    },
    {
      ":Lazy load <plugins>",
      description = "Load a plugin that has not been loaded yet",
      unfinished = true,
    },
    {
      ":Lazy log",
      description = "Show recent updates",
    },
    {
      ":Lazy log [plugins]",
      description = "Show recent updates",
      unfinished = true,
    },
    {
      ":Lazy profile",
      description = "Show detailed profiling",
    },
    {
      ":Lazy reload <plugins>",
      description = "Reload a plugin",
      unfinished = true,
    },
    {
      ":Lazy restore",
      description = "Update plugin to state in the lockfile",
    },
    {
      ":Lazy restore [plugins]",
      description = "Update plugin to state in the lockfile",
      unfinished = true,
    },
    {
      ":Lazy sync",
      description = "Run install, clean, and update",
    },
    {
      ":Lazy sync [plugins]",
      description = "Run install, clean, and update",
      unfinished = true,
    },
    {
      ":Lazy update",
      description = "Update plugins",
    },
    {
      ":Lazy update [plugins]",
      description = "Update plugins",
      unfinished = true,
    },
  })

  local LazyNvimConfig = require('lazy.core.config')
  for _, plugin in pairs(LazyNvimConfig.plugins) do
    local keys = vim.tbl_get(plugin or {}, '_', 'handlers', 'keys') or {}
    for _, keymap in pairs(keys) do
      if keymap.desc and #keymap.desc > 0 then
        -- we don't need the implementation, since
        -- lazy.nvim will have already bound it. We
        -- just need the description-only item to appear
        -- in the legendary.nvim finder.
        local legendary_keymap = {
          -- for backwards compatibility, if keymap.lhs is missing, using an old lazy.nvim so it will be keymap[1]
          keymap.lhs or keymap[1],
          description = keymap.desc,
          mode = keymap.mode, ---@type string|string[]|nil
        }
        require('legendary').keymap(legendary_keymap)
      end
    end

    local plugin_legendary_config = vim.tbl_get(plugin or {}, "legendary") or {}
    Legendary.autocmds(vim.tbl_get(plugin_legendary_config, "autocmds") or {})
    Legendary.commands(vim.tbl_get(plugin_legendary_config, "commands") or {})
    Legendary.funcs(vim.tbl_get(plugin_legendary_config, "funcs") or {})
    Legendary.itemgroups(vim.tbl_get(plugin_legendary_config, "itemgroups") or {})
    Legendary.keymaps(vim.tbl_get(plugin_legendary_config, "keymaps") or {})
  end
end
