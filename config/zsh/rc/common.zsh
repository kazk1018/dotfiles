# common.zsh

# fpath
fpath+="/usr/local/share/zsh/functions"
fpath+="/usr/local/share/zsh/site-functions"
fpath+="$HOME/.zfunc"

## colors
autoload -Uz colors
colors

export LSCOLORS=Exfxcxdxbxegedabagacad

## history
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

## bindkey
bindkey -v

## editor
export EDITOR='nvim'
export GIT_EDITOR='nvim'

## completion
autoload -Uz compinit
compinit

## python
### pyenv
if [ -e "$HOME/.pyenv" ]; then
  eval "$(pyenv init - zsh)"
fi

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

### pipenv
export PIPENV_VENV_IN_PROJECT=1

## gcloud

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/lib/google-cloud-sdk/path.zsh.inc" ]; then
  . "/Users/s08136/lib/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/lib/google-cloud-sdk/completion.zsh.inc" ]; then
  . "/Users/s08136/lib/google-cloud-sdk/completion.zsh.inc"
fi

# Tmux 
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
  if is_screen_or_tmux_running; then
    ! is_exists 'tmux' && return 1
  else
    if shell_has_started_interactively && ! is_ssh_running; then
      if ! is_exists 'tmux'; then
        echo 'Error: tmux command not found' 2>&1
        return 1
      fi

      if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*)$'; then
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
