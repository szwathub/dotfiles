#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
MPV_PATH=$DOTFILES_PATH/mpv
MPV_CONFIG_PATH=$HOME/.config/mpv

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh

SYMLINK=$(find -H "$MPV_PATH" -maxdepth 1 -name '*.symlink')

echo "$(user '\n==>') $(highlight 'Setting up MPV...')"
which mpv &> /dev/null
if [[ $? -ne 0 ]]; then
    brew install mpv --with-bundle --with-libaacs --with-libarchive --with-libbluray --with-libcaca --with-libdvdnav --with-libdvdread
else
    echo "Already installed : $(which mpv)"
fi

echo "$(user '==>') $(highlight 'Creating symlinks for mpv')"
if [ ! -d $MPV_CONFIG_PATH ]; then
    mkdir -p $MPV_CONFIG_PATH
fi

for file in $SYMLINK ; do
    target="$MPV_CONFIG_PATH/$(basename $file '.symlink')"
    symlink $file $target
done
