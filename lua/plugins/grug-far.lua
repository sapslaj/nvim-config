return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    legendary = {
      commands = {
        {
          ":GrugFar",
          description = "grug (f)ind and (r)eplace",
        },
      },
      keymaps = {
        {
          "<leader>sr",
          "<cmd>GrugFar<cr>",
          description = "grug (f)ind and (r)eplace",
          silent = true,
        },
      },
    },
  },
}
