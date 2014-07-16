# .zshrc

# Colors
autoload -Uz colors
colors

# Alias
## git
alias g='git'
alias gst='git status --short --branch' 

## commands
alias la='ls -a'
alias ll='ls -l -G'
alias lla='ls -la -G'
alias lal='ls -la -G'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '


# Left Prompt


# Right Prompt (Git)


# General Settings
export EDITOR=vim
export GIT_EDITOR=vim
export LANG=ja_JP.UTF-8


# Completion
autoload -Uz compinit
compinit

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
## zsh-completions
if [ -e .zsh/zsh-completions ]; then
  fpath=(.zsh/zsh-completions/src $fpath)
fi

## zsh-syntax-highlighting
if [ -e .zsh/zsh-syntax-highlighting ]; then
  source .zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
