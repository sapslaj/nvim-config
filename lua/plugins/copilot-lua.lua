return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      panel = {
        enabled = false,
        auto_refresh = false,
      },
      suggestion = {
        enabled = false,
        auto_trigger = false,
      },
      filetypes = {
        ["*"] = false,
      },
    },
  },
}
