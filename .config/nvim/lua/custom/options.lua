-- Enable neovim highlight yank
vim.cmd "au TextYankPost * silent! lua vim.highlight.on_yank()"
vim.opt.colorcolumn = '80,120'

