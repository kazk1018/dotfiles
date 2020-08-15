#!/bin/sh

# Command Line Tools for Xcode
xcode-select --install

# Homebrew
if [ ! -x "`which brew`" ]; then
  echo "Install homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  brew update
  brew upgrade
fi

