---
-- Settings
---

vim.wo.number = true

-- Tab set to two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.colorcolumn = '80,120'
vim.opt.mouse = 'a'

-- vim.opt.clipboard = 'unnamedplus'
-- vim.cmd('set clipboard+=unnamedplus')
vim.api.nvim_set_option("clipboard","unnamedplus")

-- Give me space
vim.opt.signcolumn = 'yes'


vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

---
-- Plugins
---

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  --use 'dracula/vim'
  use 'folke/tokyonight.nvim'

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/nvim-lsp-installer'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  --use {'scrooloose/nerdtree', as = 'NERDTreeToggle'}
  use 'ryanoasis/vim-devicons'

	-- fzf
	use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
	use {'junegunn/fzf.vim'}

  -- COC
  -- use { 'neoclide/coc.nvim', branch = 'release' }

  use 'leafgarland/typescript-vim'
  use 'peitalin/vim-jsx-typescript'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'windwp/nvim-ts-autotag'

  use 'preservim/nerdcommenter'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'RRethy/nvim-base16'

  use {
    'lewis6991/spellsitter.nvim',
  }

  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use 'glepnir/dashboard-nvim'

  use "lukas-reineke/indent-blankline.nvim"

  use 'f-person/git-blame.nvim'


  use 'nvim-lua/plenary.nvim'

  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
  use 'sbdchd/neoformat'

  use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
    require("toggleterm").setup{
      open_mapping = [[<c-t>]],
    }
  end}

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }


end)

--vim.cmd('let g:NERDTreeShowHidden = 1')
--vim.cmd('let g:NERDTreeMinimalUI = 1')
--vim.cmd('let g:NERDTreeIgnore = []')
--vim.cmd('let g:NERDTreeStatusline = ""')

vim.cmd('let g:dashboard_default_executive ="fzf"')

-- vim.cmd('let g:coc_global_extensions = ["coc-emmet", "coc-css", "coc-html", "coc-json", "coc-prettier", "coc-tsserver"]')
-- vim.cmd('command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument')
-- vim.cmd('autocmd BufRead,BufNewFile */nginx_configs/*.conf set syntax=nginx')


--vim.cmd('command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)'))

vim.cmd([[
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
]])

vim.env.FZF_DEFAULT_COMMAND = 'ag -g ""'

pcall(vim.cmd, 'colorscheme dracula')

local lsp = require('lsp-zero')

require('keymap')

--local lualine_theme = require'lualine.themes.dracula'

--require('lualine').setup {
  --options = { theme = lualine_theme }
--}

vim.g.tokyonight_style = "night"

-- Lua
vim.cmd[[colorscheme tokyonight]]
require('lualine').setup {
  options = {
    -- ... your lualine config
    theme = 'tokyonight'
    -- ... your lualine config
  }
}


require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


vim.cmd('let g:neoformat_try_node_exe = 1')
--vim.cmd('autocmd BufWritePre *.js Neoformat')
vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])


 local null_ls = require("null-ls")
 local prettier = require("prettier")

--[[ null_ls.setup({]]
   --[[on_attach = function(client, bufnr)]]
     --[[-- if client.resolved_capabilities.document_formatting then]]
        
      --[[client.resolved_capabilities.document_formatting = false]]
     
       --[[vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")]]
       --[[-- format on save]]
       --[[vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")]]
     --[[-- end]]
 
     --[[--  if client.resolved_capabilities.document_range_formatting then]]
     --[[--    vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")]]
     --[[--  end]]
   --[[end,]]
 --[[})]]
 
 prettier.setup({
   bin = 'prettier', -- or `prettierd`
   filetypes = {
     "css",
     "graphql",
     "html",
     "javascript",
     "javascriptreact",
     "json",
     "less",
     "markdown",
     "scss",
     "typescript",
     "typescriptreact",
     "yaml",
   },
 })


-- vim.cmd('colorscheme base16-darcula')
--

vim.cmd([[
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]
]])

lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

