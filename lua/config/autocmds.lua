local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- maybe fixed with folke/ts-comments.nvim
-- https://neovim.discourse.group/t/commentstring-for-terraform-files-not-set/4066
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("FixTerraformCommentString"),
--   callback = function(ev)
--     vim.bo[ev.buf].commentstring = "# %s"
--   end,
--   pattern = { "terraform", "hcl" },
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("FixPuppetCommentString"),
--   callback = function(ev)
--     vim.bo[ev.buf].commentstring = "# %s"
--   end,
--   pattern = { "puppet" },
-- })

-- Enable linebreak in Markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.cmd("set linebreak")
  end,
})
