#!/usr/bin/bash

function git_sha_list(){
    branch="$1"
    shift
    for sha in $(git log $branch --format=format:%H "$@")
    do
        echo $sha
    done
}

function git_sha_list_reversed(){
    for sha in $(sha_list "$@" | tac)
    do
        echo $sha
    done
}
