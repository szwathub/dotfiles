#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
XCODE_PATH=$DOTFILES_PATH/xcode
XCODE_USERDATA_PATH=$HOME/Library/Developer/Xcode/UserData

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh

SYMLINK=$(find -H "$XCODE_PATH" -maxdepth 1 -name '*.symlink')

echo "$(user '\n==>') $(highlight 'Setting up Xcode...')"

echo "$(user '==>') $(highlight 'Creating symlinks for Xcode')"

for file in $SYMLINK ; do
    target="$XCODE_USERDATA_PATH/$(basename $file '.symlink')"
    symlink $file $target
done
