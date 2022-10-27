-- Enable neovim highlight yank
vim.cmd "au TextYankPost * silent! lua vim.highlight.on_yank()"

-- Set line lenght markers
vim.opt.colorcolumn = "80,120"

-- vim.opt.spell = true
-- vim.opt.spelllang = 'en'

-- Set yank clipboard to use
vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.bo.softtabstop = 2

vim.g.luasnippets_path = "~/.config/nvim/lua/custom/snippets/angular"

