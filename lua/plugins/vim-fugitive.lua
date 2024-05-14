-- keybindings. nested motions aren't supported
local motions = {
  {
    "ga", "Git add --all", "add all"
  },
  {
    "gc", "Git commit -v", "commit",
  },
}

-- only command aliases
local aliases = {
  {
    "g", "Git",
  },
  {
    "ga", "Git add",
  },
  {
    "gaa", "Git add -a",
  },
  {
    "gb", "Git branch",
  },
  {
    "gbD", "Git branch -D",
  },
  {
    "gbl", "Git blame -b -w",
  },
  {
    "gbr", "Git branch --remote",
  },
  {
    "gbs", "Git bisect",
  },
  {
    "gbsb", "Git bisect bad",
  },
  {
    "gbsg", "Git bisect good",
  },
  {
    "gbsr", "Git bisect reset",
  },
  {
    "gbss", "Git bisect start",
  },
  {
    "gc", "Git commit -v ",
  },
  {
    "gc!", "Git commit -v --amend",
  },
  {
    "gca", "Git commit -a",
  },
  {
    "gca!", "Git commit -a --amend",
  },
  {
    "gcam", "Git commit -a -m",
  },
  {
    "gcan!", "Git commit -v -a --no-edit --amend",
  },
  {
    "gcans!", "Git commit -v -a -s --no-edit --amend",
  },
  {
    "gcas", "Git commit -a -s",
  },
  {
    "gcasm", "Git commit -a -s -m",
  },
  {
    "gcb", "Git checkout -b",
  },
  {
    "gcmsg", "Git commit -m",
  },
  {
    "gcn!", "Git commit -v --no-edit --amend",
  },
  {
    "gco", "Git checkout",
  },
  {
    "gcor", "Git checkout --recurse-submodules",
  },
  {
    "gcount", "Git shortlog -sn",
  },
  {
    "gcp", "Git cherry-pick",
  },
  {
    "gcpa", "Git cherry-pick --abort",
  },
  {
    "gcpc", "Git cherry-pick --continue",
  },
  {
    "gcs", "Git commit -S",
  },
  {
    "gcsm", "Git commit -s -m",
  },
  {
    "gcss", "Git commit -S -s",
  },
  {
    "gcssm", "Git commit -S -s -m",
  },
  {
    "gd", "Git diff",
  },
  {
    "gdca", "Git diff --cached",
  },
  {
    "gdcw", "Git diff --cached --word-diff",
  },
  {
    "gds", "Git diff --staged",
  },
  {
    "gdt", "Git diff-tree --no-commit-id --name-only -r",
  },
  {
    "gdw", "Git diff --word-diff",
  },
  {
    "gf", "Git fetch",
  },
  {
    "gfa", "Git fetch --all --prune --jobs=10",
  },
  {
    "gfo", "Git fetch origin",
  },
  {
    "gl", "Git pull",
  },
  {
    "glg", "Git log --stat",
  },
  {
    "glgg", "Git log --graph",
  },
  {
    "glgga", "Git log --graph --decorate --all",
  },
  {
    "glgm", "Git log --graph --max-count=10",
  },
  {
    "glgp", "Git log --stat -p",
  },
  {
    "glo", "Git log --oneline --decorate",
  },
  {
    "glog", "Git log --oneline --decorate --graph",
  },
  {
    "gloga", "Git log --oneline --decorate --graph --all",
  },
  {
    "gm", "Git merge",
  },
  {
    "gma", "Git merge --abort",
  },
  {
    "gmtl", "Git mergetool --no-prompt",
  },
  {
    "gp", "Git push",
  },
  {
    "gpd", "Git push --dry-run",
  },
  {
    "gpf", "Git push --force-with-lease",
  },
  {
    "gpf!", "Git push --force",
  },
  {
    "gpr", "Git pull --rebase",
  },
  {
    "grb", "Git rebase",
  },
  {
    "grba", "Git rebase --abort",
  },
  {
    "grbc", "Git rebase --continue",
  },
  {
    "grbi", "Git rebase -i",
  },
  {
    "grbo", "Git rebase --onto",
  },
  {
    "grbs", "Git rebase --skip",
  },
  {
    "grev", "Git revert",
  },
  {
    "grh", "Git reset",
  },
  {
    "grhh", "Git reset --hard",
  },
  {
    "grm", "Git rm",
  },
  {
    "grmc", "Git rm --cached",
  },
  {
    "grs", "Git restore",
  },
  {
    "grv", "Git remote -v",
  },
  {
    "gsb", "Git status -sb",
  },
  {
    "gsh", "Git show",
  },
  {
    "gsi", "Git submodule init",
  },
  {
    "gsps", "Git show --pretty=short --show-signature",
  },
  {
    "gss", "Git status -s",
  },
  {
    "gst", "Git status",
  },
  {
    "gsta", "Git stash push",
  },
  {
    "gstaa", "Git stash apply",
  },
  {
    "gstall", "Git stash --all",
  },
  {
    "gstc", "Git stash clear",
  },
  {
    "gstd", "Git stash drop",
  },
  {
    "gstl", "Git stash list",
  },
  {
    "gstp", "Git stash pop",
  },
  {
    "gsts", "Git stash show --text",
  },
  {
    "gsu", "Git submodule update",
  },
  {
    "gsw", "Git switch",
  },
  {
    "gswc", "Git switch -c",
  },
  {
    "gts", "Git tag -s",
  },
}

return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "konfekt/vim-alias",
    },
    legendary = {
      autocmds = {
        {
          "VimEnter",
          function()
            for _, alias in ipairs(aliases) do
              vim.cmd("Alias " .. alias[1] .. " " .. string.gsub(alias[2], " ", "\\ "))
            end
          end
        },
      },
    },
  },
}
