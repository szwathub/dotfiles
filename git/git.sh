#! /usr/bin/env sh

set -e

DOTFILES_PATH=$(cd "$(dirname "$0")";pwd)
GIT_PATH=$DOTFILES_PATH/git

DEFAULT_NAME=szwathub
DEFAULT_EMAIL=szwathub@gmail.com
DEFAULT_GITHUB=szwathub

. $DOTFILES_PATH/scripts/color.sh
. $DOTFILES_PATH/scripts/symlink.sh

SYMLINK=$(find -H "$GIT_PATH" -maxdepth 1 -name '*.symlink')

echo "$(user '\n==>') $(highlight 'Setting up Git...')"
which git &> /dev/null
if [[ $? -ne 0 ]]; then
    brew install git
else
    echo "Already installed : $(which git)"
fi

echo "$(user '==>') $(highlight 'Creating symlinks for git')"
for file in $SYMLINK ; do
    target="$HOME/$(basename $file '.symlink')"
    symlink $file $target
done

echo "$(user '==>') $(highlight 'Setting up git configuration...')"
read -p "Name [$DEFAULT_NAME] : " name
read -p "Email [$DEFAULT_EMAIL] : " email
read -p "Github Username [$DEFAULT_GITHUB] : " github

git config --global user.name "${name:-$DEFAULT_NAME}"
git config --global user.email "${email:-$DEFAULT_EMAIL}"
git config --global github.user "${github:-$DEFAULT_GITHUB}"

# set up user and email for different repo
mkdir -p ~/.git-templates/hooks
cp $GIT_PATH/githook/post-checkout ~/.git-templates/hooks/
git config --global init.templatedir ~/.git-templates

if [[ "$( uname )" == "Darwin" ]]; then
    # can get information by command git credential-osxkeychain
    # need git >= 1.7.9
    git config --global credential.helper "osxkeychain"
else
    read -n 1 -p "Save user and password to an unencrypted file to avoid writing? [y/N] " save
    if [[ $save =~ ^([Yy])$ ]]; then
        git config --global credential.helper "store"
    else
        git config --global credential.helper "cache --timeout 3600"
    fi
fi
