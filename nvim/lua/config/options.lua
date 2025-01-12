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

vim.g.lazyvim_picker = "telescope"

-- vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

-- local opt = vim.opt
--
-- opt.smoothscroll = true
--
-- vim.o.scrolloff = 3
-- vim.o.sidescrolloff = 3
-- vim.o.ttymouse = "sgr"
-- vim.o.updatetime = 50
