return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
    legendary = {
      commands = {
        {
          ":Mason",
          description = "Mason - open a graphical status window",
        },
        {
          ":MasonUpdate",
          description = "Mason - update all managed registries",
        },
        {
          ":MasonInstall <package> ...",
          description = "Mason - installs/re-installs the provided packages",
          unfinshed = true,
        },
        {
          ":MasonUninstall <package> ...",
          description = "Mason - uninstalls the provided packages",
          unfinshed = true,
        },
        {
          ":MasonUninstallAll",
          description = "Mason - uninstalls all packages",
        },
        {
          ":MasonLog",
          description = "Mason - opens the mason.nvim log file in a new tab window",
        },
      },
    },
  },
}
