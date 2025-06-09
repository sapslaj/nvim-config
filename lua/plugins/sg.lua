local Lsp = require("util.lsp")

return {
  {
    "sourcegraph/sg.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    enabled = os.getenv("NVIM_ENABLE_SOURCEGRAPH") == "true",
    opts = {
      on_attach = Lsp.on_attach,
    },
    legendary = {
      commands = {
        {
          ":CodyAsk",
          description = "Ask a question about the current selection.",
        },
        {
          ":CodyExplain",
          description = "Ask a question about the current selection.",
        },
        {
          ":CodyChat [title]",
          description = "Start a new cody chat, with an optional {title}",
        },
        {
          ":CodyToggle",
          description = "Toggles the current Cody Chat window.",
        },
        {
          ":CodyTask <task_descripton>",
          description = "Instruct Cody to perform a task on selected text.",
        },
        {
          ":CodyRestart",
          description = "Restarts Cody and Sourcegraph, clearing all state.",
        },
        {
          ":SourcegraphLogin",
          description = "Get prompted for endpoint and access_token if you don't",
        },
        {
          ":SourcegraphClear",
          description = "Remove Sourcegraph Login information",
        },
        {
          ":SourcegraphBuild",
          description = "Rebuild the Sourcegraph crates and required dependencies (in case build failed during installation)",
        },
        {
          ":SourcegraphDownloadBinaries",
          description = "(Re-)Download the sourcegraph binaries. This should happen during installation",
        },
        {
          ":SourcegraphLink",
          description = "Get a sourcegraph link to the current repo + file + line.",
        },
        {
          ":SourcegraphSearch",
          description = "Run a search. For more sourcegraph search syntax, refer to online documentation",
        },
        {
          ":CodyIgnoreNotification",
          description = "Ingore particular notifications",
        },
      },
    },
  },
}
