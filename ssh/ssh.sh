#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
SSH_PATH=$DOTFILES_PATH/ssh
SSH_CONFIG_PATH=$HOME/.ssh

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh

SYMLINK=$(find -H "$SSH_PATH" -maxdepth 1 -name '*.symlink')

echo "$(user '==>') $(highlight 'Creating symlinks for ssh')"
if [ ! -d $SSH_CONFIG_PATH ]; then
    mkdir -p $SSH_CONFIG_PATH
fi

for file in $SYMLINK ; do
    target="$SSH_CONFIG_PATH/$(basename $file '.symlink')"
    symlink $file $target
done
