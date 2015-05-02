# Make sure using latest Homebrew
brew update

# Update already-installed formula
brew upgrade

# Install brew-cask
brew install caskroom/cask/brew-cask

# Setting Caskroom path
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

# Install Packages
brew install zsh
brew install git
brew install wget
brew install pyenv
brew install pyenv-virtualenv
brew install nvm
brew install rbenv
brew install go --with-cc-common
brew install fontforge
brew install vim
brew install ag
brew install motemen/ghq/ghq
brew install peco/peco/peco
brew install Caskroom/cask/xquartz

# Install Applications
brew tap caskroom/homebrew-versions

brew cask install google-japanese-ime
brew cask install google-chrome
brew cask install java
brew cask install java7
brew cask install iterm2
brew cask install sublime-text3
brew cask install bettertouchtool
brew cask install dropbox
brew cask install thunderbird
brew cask install skype
brew cask install kobito

# Install Font
brew tap sanemat/font
brew install ricty
cp -f /usr/local/Cellar/ricty/*/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf

