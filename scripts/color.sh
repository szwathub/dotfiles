#! /usr/bin/env sh

highlight () {
    echo "\033[1m$1\033[0m"
}

info () {
    echo "\033[35m$1\033[0m"
}

user () {
    echo "\033[34m$1\033[0m"
}

warning () {
    echo "\033[33m$1\033[0m"
}

success () {
    echo "\033[32m$1\033[0m"
}

failure () {
    echo "\033[31m$1\033[0m"
    exit
}
