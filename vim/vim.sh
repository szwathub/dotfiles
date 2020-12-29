#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
VIM_PATH=$DOTFILES_PATH/vim
VIM_CONFIG_PATH=$HOME/.vim

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh

SYMLINK=$(find -H "$VIM_PATH" -maxdepth 1 -name '*.symlink')

echo "$(user '\n==>') $(highlight 'Setting up Vim...')"
which vim &> /dev/null
if [[ $? -ne 0 ]]; then
    brew install vim --with-override-system-vi
else
    echo "Already installed : $(which vim)"
fi

echo "$(user '==>') $(highlight 'Creating symlinks for vim')"
for file in $SYMLINK ; do
    target="$HOME/$(basename $file '.symlink')"
    symlink $file $target
done

echo "$(user '==>') $(highlight 'Installing plugins for vim')"
vim -c "PluginInstall" -c "q" -c "q" &> /dev/null
if [[ $? -eq 0 ]]; then
    echo "$(success '==>') $(highlight 'All plugins up-to-date.')"
fi
