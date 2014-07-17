
set title
syntax on
set tabstop=4	

"
" NeoBundle
"
if has('vim_starting')
	set nocompatible

	set runtimepath+=.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" NERDTree
NeoBundle 'scrooloose/nerdtree'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
