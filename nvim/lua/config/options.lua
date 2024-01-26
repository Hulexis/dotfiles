-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.filetype.add({ extension = { mdx = "mdx" } })

vim.shiftwidth = 2

vim.g.python_recommended_style = 0

vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.smartident = true
vim.o.autoindent = true

vim.o.listchars = "tab:!·,trail:·"
vim.o.list = false

vim.opt_local.conceallevel = 2
