#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
GNUPG_PATH=$DOTFILES_PATH/gnupg
GNUPG_CONFIG_PATH=$HOME/.gnupg

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh

SYMLINK=$(find -H "$GNUPG_PATH" -maxdepth 1 -name '*.symlink')

echo "$(user '\n==>') $(highlight 'Setting up GnuPG...')"
which gpg &> /dev/null
if [[ $? -ne 0 ]]; then
    brew install gpg
else
    echo "Already installed : $(which gpg)"
fi

which pinentry-mac &> /dev/null
if [[ $? -ne 0 ]]; then
    brew install pinentry-mac
else
    echo "Already installed : $(which pinentry-mac)"
fi

echo "$(user '==>') $(highlight 'Creating symlinks for gnupg')"
if [ ! -d $GNUPG_CONFIG_PATH ]; then
    mkdir -p $GNUPG_CONFIG_PATH
fi

for file in $SYMLINK ; do
    target="$GNUPG_CONFIG_PATH/$(basename $file '.symlink')"
    symlink $file $target
done
