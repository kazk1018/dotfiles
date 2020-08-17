" init.vim

if &compatible
  set nocompatible
endif

" reset filetype
filetype on

augroup MyAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *? call vimrc#on_filetype()
augroup END

" rc directory
let s:rc_dir = expand('$XDG_CONFIG_HOME/nvim/rc')

if has('vim_starting')
  " use English interface
  language message C
 
  " define <Leader>
  let g:mapleader = "\<Space>"
endif

" dein
execute 'source' fnameescape(s:rc_dir . '/dein.rc.vim')

if has('vim_starting') && !empty(argv())
  call vimrc#on_filetype()
endif

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')

  syntax enable
  filetype plugin indent on
endif

" neovim
execute 'source' fnameescape(s:rc_dir . '/neovim.rc.vim')

" set number
set number

" colors
set t_Co=256

if exists('+termguicolors')
  set termguicolors
endif

colorscheme molokai

" shortcuts
inoremap { {}<Left>
inoremap {} {}
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap () ()
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<ESC>i
inoremap [] []
inoremap < <><ESC>i
inoremap <> <>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
