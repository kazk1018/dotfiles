 # .zshrc

# Colors
autoload -Uz colors
colors

export LSCOLORS=Exfxcxdxbxegedabagacad


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

## commands
alias ls='ls -G'
alias la='ls -a -G'
alias ll='ls -l -G'
alias lla='ls -la -G'
alias lal='ls -la -G'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo -E '

alias v='vagrant'

# Prompt
local p_cdir="%F{green}[%~]$f%b"$'\n'
local p_info="[%n@%m]%# "
PROMPT="$p_cdir$p_info"
RPROMPT="%1(v|%F{green}%1v%f|)"


# General Settings
export EDITOR=vim
export GIT_EDITOR=vim
export LANG=ja_JP.UTF-8
export DOTFILES=$HOME/dotfiles

# Completion
autoload -Uz compinit
compinit -C

## 補完で小文字でも大文字にマッチさせる
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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

## zsh-completions
if [ -e $DOTFILES/.zsh/zsh-completions ]; then
  fpath=($DOTFILES/.zsh/zsh-completions/src $fpath)
fi

## zsh-syntax-highlighting
if [ -e $DOTFILES/.zsh/zsh-syntax-highlighting ]; then
  source $DOTFILES/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# SSH 
# source ~/.zsh_ssh


# App & Library

# node & nvm initialization
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir
nvm use v0.10.33

# JAVA_HOME
export JAVA_HOME=`/usr/libexec/java_home`
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

# /usr/local/bin
export PATH=/usr/local/bin:$PATH

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# pyenv
if [ -e $HOME/.pyenv ]; then
  export PATH="$PATH:$HOME/.pyenv/bin"
  eval "$(pyenv init - zsh)"
  eval "$(pyenv virtualenv-init -)"
  export PYENV_VERSION=2.7.8 
fi

# rvm
if [ -e $HOME/.rvm ]; then
  export PATH="$PATH:$HOME/.rvm/bin"
fi

eval "$(rbenv init -)"
