#! /bin/sh

DOT_FILES=( .zshrc .gitconfig .gitignore .vim .vimrc .gitmodules .tmux.conf .config/nvim ) 
REPO_PATH="" 

if [ -e $HOME/dotfiles ]; 
then
    REPO_PATH=$HOME/dotfiles
elif [ -e $HOME/.ghq/github.com/kazk1018/dotfiles ];
then
    REPO_PATH=$HOME/.ghq/github.com/kazk1018/dotfiles
else
    echo "Cannot find dotfiles repository in your home directory."
    exit 1
fi

for dotfile in ${DOT_FILES[@]} 
do
    if [ ! -e $HOME/$dotfile ];
    then
        ln -s "${REPO_PATH}/$dotfile" $HOME/$dotfile
    fi
done

echo "successful!"
exit 0
