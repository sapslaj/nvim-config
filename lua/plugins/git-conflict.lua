return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {},
    legendary = {
      commands = {
        {
          ":GitConflictChooseOurs",
          description = "Select the current changes",
        },
        {
          ":GitConflictChooseTheirs",
          description = "Select the incoming changes",
        },
        {
          ":GitConflictChooseBoth",
          description = "Select both change",
        },
        {
          ":GitConflictChooseNone",
          description = "Select none of the changes",
        },
        {
          ":GitConflictNextConflict",
          description = "Move to the next conflict",
        },
        {
          ":GitConflictPrevConflict",
          description = "Move to the previous conflict",
        },
        {
          ":GitConflictListQf",
          description = "Get all conflict to quickfix",
        },
      },
    },
  },
}
