return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    enabled = vim.loop.os_uname().sysname == "Darwin",
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
        confini = false,
        sh = false,
        ["*"] = true,
      },
    },
    keys = {
      { "<leader>cpe", ":Copilot enable<cr>", desc = "Enable Copilot" },
      { "<leader>cpd", ":Copilot disable<cr>", desc = "Disable Copilot" },
    }
  },
}
