return {
  {
    "rest-nvim/rest.nvim",
    legendary = {
      commands = {
        {
          ":Rest open",
          description = "Open result pane",
        },
        {
          ":Rest run",
          description = "Run request under the cursor",
        },
        {
          ":Rest run <name><CR>",
          description = "Run request with name <name>",
          unfinished = true,
        },
        {
          ":Rest last",
          description = "Run last request",
        },
        {
          ":Rest logs",
          description = "Edit logs file",
        },
        {
          ":Rest cookies",
          description = "Edit cookies file",
        },
        {
          ":Rest env show",
          description = "Show dotenv file registered to current .http file",
        },
        {
          ":Rest env select",
          description = "Select & register .env file",
        },
        {
          ":Rest env set <path><CR>",
          description = "Register .env file to current .http file",
          unfinished = true,
        },
      },
    },
  }
}
