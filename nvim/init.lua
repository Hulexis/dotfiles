-- require("custom.options")

vim.opt.title = true

vim.cmd "au TextYankPost * silent! lua vim.highlight.on_yank()"

