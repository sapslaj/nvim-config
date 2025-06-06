local Lsp = require("util.lsp")

return {
  {
    "sourcegraph/sg.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    enabled = os.getenv("NVIM_ENABLE_SOURCEGRAPH") ~= "true",
    opts = {
      on_attach = Lsp.on_attach,
    },
  },
}
