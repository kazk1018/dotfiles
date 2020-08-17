# .zshenv

## env
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## path
export PATH=/usr/local/bin:$PATH

## load .zshrc from XDG Base Directory
if [[ -z "$XDG_CONFIG_HOME" ]]; then  
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -e "$XDG_CONFIG_HOME/zsh" ]]; then
  export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi

