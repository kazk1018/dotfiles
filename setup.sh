#!/bin/sh

BASE_DIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [[ -z "$XDG_CONFIG_HOME" ]]; then  
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_DATA_HOME="$HOME/.local/share"
fi

mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME

if [ ! -e "$HOME/.zshenv" ]; then
    ln -s "$BASE_DIR/.zshenv" $HOME/.zshenv
fi

if [ ! -e "$HOME/.gitconfig" ]; then
    ln -s "$BASE_DIR/.gitconfig" $HOME/.gitconfig
fi

if [ ! -e "$XDG_CONFIG_HOME/zsh" ]; then
    ln -s "$BASE_DIR/config/zsh" "$XDG_CONFIG_HOME/zsh"
fi

if [ ! -e "$XDG_CONFIG_HOME/tmux" ]; then
    ln -s "$BASE_DIR/config/tmux" "$XDG_CONFIG_HOME/tmux"

    if [ ! -e "$HOME/.tmux.conf" ]; then
        ln -s "$BASE_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf"
    fi
fi

if [ ! -e "$XDG_CONFIG_HOME/nvim" ]; then
    ln -s "$BASE_DIR/config/nvim" "$XDG_CONFIG_HOME/nvim"
fi

echo "successful!"
exit 0
