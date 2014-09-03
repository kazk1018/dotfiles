
" Pyenv
let $PATH = "~/.pyenv/shims:".$PATH

"
" NeoBundle
"
if has('vim_starting')
	set nocompatible

	set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('$HOME/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'
NeoBundle 'AndrewRadev/switch.vim'

NeoBundle 'scrooloose/nerdtree'

NeoBundle 'mattn/emmet-vim'

NeoBundle 'sudo.vim'

NeoBundle 'ujihisa/unite-colorscheme'

NeoBundleLazy "davidhalter/jedi-vim", {
    \ "autoload": {
    \   "filetypes": ["python", "python3", "djangohtml"],
    \ },
    \ "build": {
    \   "mac": "pip install jedi",
    \   "unix": "pip install jedi",
    \ }}

NeoBundleLazy "lambdalisue/vim-pyenv", {
    \ "depends": ['davidhalter/jedi-vim'],
    \ "autoload": {
    \   "filetypes": ["python", "python3", "djangohtml"]
    \ }}

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" NERDTree "
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#popup_select_first = 0

let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" Backspase
set backspace=indent,eol,start

colorscheme monokai
syntax enable 

set title
set number

" tab space
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" backup
set nobackup
