#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
FISH_PATH=$DOTFILES_PATH/fish
FISH_CONFIG_PATH=$HOME/.config/fish

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh

SYMLINK=$(find -H "$FISH_PATH" -maxdepth 1 -name '*.symlink')

echo "$(user '\n==>') $(highlight 'Setting up Fish...')"
which fish &> /dev/null
if [[ $? -ne 0 ]]; then
    brew install fish
else
    echo "Already installed : $(which fish)"
fi

echo "$(user '==>') $(highlight 'Creating symlinks for fish')"
if [ ! -d $FISH_CONFIG_PATH ]; then
    mkdir -p $FISH_CONFIG_PATH
fi

for file in $SYMLINK ; do
    target="$FISH_CONFIG_PATH/$(basename $file '.symlink')"
    symlink $file $target
done
