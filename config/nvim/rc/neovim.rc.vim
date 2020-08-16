" neovim.rc.vim

" if has('vim_starting') && empty(argv())
"   syntax off
" endif

" python
" let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

if exists('&inccommand')
  set inccommand=split
endif
