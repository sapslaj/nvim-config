return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {},
    legendary = {
      commands = {
        {
          ":TSContextEnable",
          description = "Enable Treesitter context",
        },
        {
          ":TSContextDisable",
          description = "Disable Treesitter context",
        },
        {
          ":TSContextToggle",
          description = "Toggle enabling/disabling Treesitter context",
        },
      },
    },
  },
}
