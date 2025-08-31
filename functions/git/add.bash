#!/usr/bin/bash

function git-add(){
    pattern="${1//\*/.\*}"
    git add $(git status | grep "$pattern" | awk -F':' '{print $2}')
}
