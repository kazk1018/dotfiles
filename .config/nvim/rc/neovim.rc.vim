" neovim.rc.vim

" if has('vim_starting') && empty(argv())
"   syntax off
" endif

" python in pyenv
let g:python_host_prog  = $HOME . '/.pyenv/versions/2.7.12/envs/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/3.6.2/envs/neovim/bin/python3'

if exists('&inccommand')
  set inccommand=split
endif
