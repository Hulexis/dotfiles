-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.filetype.add({ extension = { mdx = "mdx" } })

vim.shiftwidth = 2

vim.g.python_recommended_style = 0

vim.o.expandtab = false
vim.o.tabstop = 2
-- vim.o.smartident = true
vim.o.autoindent = true

vim.o.listchars = "tab:!·,trail:·"
vim.o.list = false

vim.opt_local.conceallevel = 2

vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor", -- Block cursor for normal, visual, and command modes
	"i:ver25-Cursor/lCursor", -- Thin vertical line for insert mode
}

vim.g.lazyvim_prettier_needs_config = true

local opt = vim.opt

opt.smoothscroll = true
