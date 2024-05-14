return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- build = ":Copilot auth",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = false,
        auto_trigger = true,
      },
      filetypes = {
        ["*.env"] = false,
        ["*"] = true,
      },
    },
  },
}
