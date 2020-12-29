#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
HOMEBREW_PATH=$DOTFILES_PATH/homebrew

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh


echo "$(user '\n==>') $(highlight 'Setting up Homebrew...')"
which brew &> /dev/null
if [[ $? -ne 0 ]]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Already installed : $(which brew)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
# brew upgrade --all
# We decided to not change the behaviour of `brew upgrade` so
# `brew upgrade --all` is equivalent to `brew upgrade` without any other
# arguments (so the `--all` is a no-op and can be removed).
brew upgrade
brew cleanup

echo "$(user '==>') $(highlight 'Installing homebrew packages...')"
cd $HOMEBREW_PATH
brew bundle
cd $DOTFILES_PATH
