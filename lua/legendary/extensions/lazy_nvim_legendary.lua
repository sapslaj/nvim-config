local legendary = require("legendary")
local log = require("legendary.log")

return function()
  local has_lazy, _ = pcall(require, "lazy")
  if not has_lazy then
    log.warn("lazy.nvim integration is enabled, but cannot `require('lazy')`, aborting.")
    return
  end

  local LazyNvimConfig = require("lazy.core.config")
  for _, plugin in pairs(LazyNvimConfig.plugins) do
    local lazy_keys = vim.tbl_get(plugin or {}, "_", "handlers", "keys") or {}
    for _, keymap in pairs(lazy_keys) do
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
        require("legendary").keymap(legendary_keymap)
      end
    end

    local plugin_legendary_config = vim.tbl_get(plugin or {}, "legendary") or {}
    legendary.autocmds(vim.tbl_get(plugin_legendary_config, "autocmds") or {})
    legendary.commands(vim.tbl_get(plugin_legendary_config, "commands") or {})
    legendary.funcs(vim.tbl_get(plugin_legendary_config, "funcs") or {})
    legendary.itemgroups(vim.tbl_get(plugin_legendary_config, "itemgroups") or {})
    legendary.keymaps(vim.tbl_get(plugin_legendary_config, "keymaps") or {})
  end
end
