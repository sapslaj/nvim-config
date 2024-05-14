if vim.loop.os_uname().sysname ~= "Darwin" then
  return {}
end

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
    keys = {
      { "<leader>cpe", ":Copilot enable<cr>", desc = "Enable Copilot" },
      { "<leader>cpd", ":Copilot disable<cr>", desc = "Disable Copilot" },
    }
  },
}
