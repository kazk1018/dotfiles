#! /bin/sh

DOT_FILES=( .zshrc .gitconfig .gitignore .vim .vimrc .gitmodules .tmux.conf ) 

if [ ! -e $HOME/dotfiles ];
then
    echo "Cannot find dotfiles repository in your home directory."
    exit 1
fi

for dotfile in ${DOT_FILES[@]} 
do
    if [ ! -e $HOME/$dotfile ];
    then
        ln -s $HOME/dotfiles/$dotfile $HOME/$dotfile
    fi
done

echo "successful!"
exit 0
