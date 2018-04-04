" dein.rc.vim

let s:dein_dir = expand('$XDG_CACHE_HOME/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, expand('<sfile>'))

  let s:rc_dir = expand('$XDG_CONFIG_HOME/nvim/rc')
  call dein#load_toml(s:rc_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:rc_dir . '/dein_lazy.toml', {'lazy': 1})

  if dein#tap('deoplete.nvim') && has('nvim')
    call dein#disable('neocomplete.vim')
  endif

  call dein#end()
  call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif
