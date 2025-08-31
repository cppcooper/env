#!/usr/bin/bash

function git-reset(){
    pattern="${1//\*/.\*}"
    if [[ ! -z $pattern ]]
    then
        #echo "git checkout HEAD -- \$(git status | grep \"$pattern\" | awk '{print $2}')"
        for file in $(git status | grep "$pattern" | awk -F':' '{print $2}')
        do
            echo "git checkout HEAD -- $file"
            git checkout HEAD -- $file
        done
    else
        echo "error: no pattern to match"
    fi
}
