#! /usr/bin/env sh

function symlink() {
    if [ -d $1 ]; then
        # file is a directory.
        if [[ ! -d $2 ]]; then
            mkdir -p $2
        fi
        filelist=$(ls $1)
        for subfile in $filelist ; do
            symlink $1/$subfile $2/$subfile
        done
    else
        OVERWRITTEN=""
        if [ -e "$2" ] || [ -h "$2" ]; then
            OVERWRITTEN="(override)"
            rm -r "$2"
        fi
        echo "\033[1mCreating symlink for $1\033[0m \033[35m$OVERWRITTEN\033[0m"
        ln -s "$1" "$2"
    fi
}

IFS=$'\n'
