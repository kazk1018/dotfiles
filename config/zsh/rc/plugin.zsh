# plugin.zsh

## zplug init
export ZPLUG_HOME=/usr/local/opt/zplug

if [[ ! -e "$ZPLUG_HOME" ]]; then
  echo "zplug is not installed."
  return 1
fi

## zplug plugins
source $ZPLUG_HOME/init.zsh

## theme
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", from:github
# zplug "dracula/zsh", as:theme

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "b4b4r07/enhancd", use:init.sh

zplug "mollifier/anyframe"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

## install zplug plugins
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

## load plugins
zplug load

## plugins configuration

### Dracula

export DRACULA_DISPLAY_CONTEXT=1
export DRACULA_ARROW_ICON="-> "

### enhenced
export ENHANCD_FILTER=fzf-tmux
export ENHANCD_DISABLE_DOT=1

if [[ ! -e "$XDG_CACHE_HOME/enhanced" ]]; then
  mkdir "$XDG_CACHE_HOME/enhanced"
fi

export ENHANCD_DIR="$XDG_CACHE_HOME/enhanced"

### anyframe
zstyle ":anyframe:selector:" use fzf-tmux
zstyle ":anyframe:selector:fzf-tmux:" command 'fzf-tmux --extended'

bindkey '^r' anyframe-widget-put-history
bindkey '^f' anyframe-widget-cd-ghq-repository

### zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# color settings
zstyle ':prompt:pure:path' color cyan