# .zshrc

# Colors
autoload -Uz colors
colors

export LSCOLORS=Exfxcxdxbxegedabagacad

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# XDG Base Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# vi mode
bindkey -v
function zle-line-init zle-keymap-select {
  vimode="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"
  if [ -n "$TMUX" ]; then
    if [ $vimode = "NORMAL" ]; then
      modebg="colour25"
      modefg="colour255"
    else
      modebg="colour196"
      modefg="colour255"
    fi
    tmux set -g status-left "#[bg=${modebg}, fg=${modefg}] $vimode " > /dev/null
  fi
}
zle -N zle-line-init
zle -N zle-keymap-select

# tmux 
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_tmux_running() { [ ! -z "$TMUX" ]; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_tmux_running; then
        ! is_exists 'tmux' && return 1
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session


# git
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}


# Alias
## git
alias g='git'
alias gst='git status --short --branch' 
alias sb="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias mou='open -a Mou'
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias nb="jupyter notebook"
alias nbc="jupyter notebook --notebook-dir ."
alias nb='nodebrew'
alias vim='/usr/local/bin/nvim'
alias ipy='ipython'
alias py='python2'
alias py3='python3'
alias act='source .venv/bin/activate'
alias deact='deactivate'

## commands
alias ls='ls -G'
alias ll='ls -lFhG'
alias la='ls -lAFhG'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo -E '
alias d='docker'
alias c='code'
alias v='vagrant'

# Prompt
local p_cdir="%B[%c]%b"
PROMPT="%(?.%F{6}.%F{1})$p_cdir %#%f "
RPROMPT="%1(v|%F{green}%1v%f|)"

# General Settings
export EDITOR='nvim'
export GIT_EDITOR='nvim'
export LANG=ja_JP.UTF-8
export DOTFILES=$HOME/.ghq/github.com/kazk1018/dotfiles
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 補間時にカーソル選択できるようにする
zstyle ':completion:*:default' menu select=1

## psコマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

 
# Options
## =の後ろでも補間する 
setopt magic_equal_subst

## beep無効
setopt no_beep

## ディレクトリ名でcdする
setopt auto_cd

## cdしたら自動的にpushdする
setopt auto_pushd

## 重複したディレクトリを追加しない
setopt pushd_ignore_dups

## スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

## 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

## 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

## ディレクトリ名の補間の後ろで/を追加
setopt auto_param_slash

## ディレクトリに/を追加する
setopt mark_dirs

# Plugins

# fpath
fpath=($HOME/.zfunc $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)

## zsh-completions
if [ -e $DOTFILES/.zsh/zsh-completions ]; then
  fpath=($DOTFILES/.zsh/zsh-completions/src $fpath)
fi

## zsh-syntax-highlighting
if [ -e $DOTFILES/.zsh/zsh-syntax-highlighting ]; then
  source $DOTFILES/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Completion
autoload -Uz compinit
compinit

# SSH 
# source ~/.zsh_ssh

# App & Library

# /usr/local/bin
export PATH=/usr/local/bin:$PATH

# JAVA_HOME
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

# pyenv
if [ -e $HOME/.pyenv ]; then
  export PATH="$PATH:$HOME/.pyenv/bin"
  eval "$(pyenv init - zsh)"
  export PYENV_VERSION=system 
fi

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# rbenv
eval "$(rbenv init -)"
export RBENV_VERSION=2.6.3

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
if [ -e $HOME/.goenv ]; then
  eval "$(goenv init -)"
  export GOENV_VERSION=1.13.0
  export GOROOT=`go env GOROOT`
fi

# GOPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

alias gp="cd $GOPATH/src/github.com/kazk1018"

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# nodebrew
export NODEBREW_ROOT=/usr/local/var/nodebrew
export PATH=$NODEBREW_ROOT/current/bin:$PATH

# direnv
eval "$(direnv hook zsh)"

# peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^f' peco-src

function peco-pyenv () {
  local selected_env=$(ls ${HOME}/.pyenv/versions | peco --query "$LBUFFER")
  if [ -n "$selected_env" ]; then
    BUFFER="pyenv shell ${selected_env}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-pyenv
bindkey '^p' peco-pyenv

function peco-go () {
  local selected_dir=$(ls -d ${GOPATH}/src/github.com/*/* | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-go
bindkey '^g' peco-go

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
    eval $tac | \
    peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# The next line updates PATH for the Google Cloud SDK.
source "${HOME}/lib/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
source "${HOME}/lib/google-cloud-sdk/completion.zsh.inc"

# pipenv
export PIPENV_VENV_IN_PROJECT=1
