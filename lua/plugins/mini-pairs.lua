return {
  {
    "echasnovski/mini.pairs",
    opts = {
      modes = {
        insert = true,
        command = false,
        terminal = false,
      },
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

        -- [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        -- ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        -- ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

        [")"] = false,
        ["]"] = false,
        ["}"] = false,

        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    },
  },
}
