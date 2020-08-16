# .zshrc

if [[ -z "$ZDOTDIR" ]]; then
  echo "Please set correct '\$ZDOTDIR'."
fi

if [[ ! -e "$ZDOTDIR/.zshrc" ]]; then
  echo "File '.zshrc' cannot not be found."
fi

# load rc/*.zsh
source $ZDOTDIR/rc/common.zsh
source $ZDOTDIR/rc/plugin.zsh
source $ZDOTDIR/rc/alias.zsh
