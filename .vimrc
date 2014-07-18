
"
" NeoBundle
"
if has('vim_starting')
	set nocompatible

	set runtimepath+=.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'scrooloose/nerdtree'

NeoBundle 'mattn/emmet-vim'

NeoBundle 'sudo.vim'

NeoBundle 'ujihisa/unite-colorscheme'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" Backspase
set backspace=indent,eol,start

syntax on

set title
set number

" tab space
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" backup
set nobackup
