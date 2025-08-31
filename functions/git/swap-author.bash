#!/usr/bin/bash

export SWAPPED_NAME="data-uploader"
export SWAPPED_EMAIL="cooper.s.josh@data.com"
function git-swap-author(){
    Name="$(git config user.name)"
    Email="$(git config user.email)"
    if [[ (! -z $1) && (! -z $2) ]]
    then
        git config --global user.name "$1"
        export SWAPPED_NAME="$Name"
        git config --global user.email "$2"
        export SWAPPED_EMAIL="$Email"
    else
        if [[ ! -z $SWAPPED_NAME ]]
        then
            git config --global user.name "$SWAPPED_NAME"
            export SWAPPED_NAME="$Name"
        fi
        if [[ ! -z $SWAPPED_EMAIL ]]
        then
            git config --global user.email "$SWAPPED_EMAIL"
            export SWAPPED_EMAIL="$Email"
        fi
    fi
    echo -e "Name:      $SWAPPED_NAME\nEmail:     $SWAPPED_EMAIL\n---------------------\nNew Name:  $(git config user.name)\nNew Email: $(git config user.email)\n"
}
