set number
syntax on


set tabstop=4
set autoindent
set expandtab
set cursorline
set hlsearch

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'preservim/NERDTree'
Plug 'tomtom/TComment'
Plug 'tpope/vim-surround'
call plug#end()

function! Comment()
    let ext = tolower(expand('%:e'))
    if ext == 'py' 
        let cmt1 = "'''"
        let cmt2 = "'''"   
    elseif ext == 'cpp' || ext =='java' || ext == 'css' || ext == 'js'|| ext == 'ts' || ext == 'c' || ext =='cs' || ext == 'rs' || ext == 'go'
        let cmt1 = '/*'
        let cmt2 = '*/'
    elseif ext == 'sh'
        let cmt1 = ":'"
        let cmt2 = "'"
    elseif ext == 'html'
        let cmt1 = "<!--"
        let cmt2 = "-->"
    elseif ext == 'hs'
        let cmt1 = "{-"
        let cmt2 = "-}"
    elseif ext == "rb"
        let cmt1 = "=begin"
        let cmt2 = "=end"
    endif
    exe line("'<")."normal O". cmt1 | exe line("'>")."normal o". cmt2 
endfunction

function! UnComment()
    exe line("'<")."normal dd" | exe line("'>")."normal dd"   
endfunction


vnoremap ,m :<c-w><c-w><c-w><c-w><c-w>call Comment()<CR>
vnoremap m, :<c-w><c-w><c-w><c-w><c-w>call UnComment()<CR>

