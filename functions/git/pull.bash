#!/usr/bin/bash

function git-pull(){
    arg=$1
    shift
    if [[ $arg == "--branch" ]]
    then
        if [[ -z $1 ]]
        then
            git pull
        else
            git fetch origin "$1":"$1";
        fi
    elif [[ ($arg == "--no-rebase") || ($arg == "--ff") ]]
    then
        git pull --no-rebase --ff "$@"
    else
        echo "No arguments provided, perhaps you want \`git pull\` instead?"
        echo "Arguments accepted --branch or [--no-rebase, --ff]"
    fi
}

function git-pull-all(){
    cur_branch="$(git branch | grep \* | cut -d ' ' -f2)"
    git branch -r | grep -v '\->' | while read remote
    do
        branch="${remote#origin/}"
        if [[ $cur_branch == $branch ]]
        then
            continue
        fi
        exec 5>&1
        msg="$(git fetch origin $branch:$branch|&tee /dev/fd/5)"
        exec 5>&-
        if [[ -z $msg ]]
        then
            echo -e "[$branch]\n Already up to date."
        fi
    done
    echo -e "\n"
    git submodule update --init --recursive
    echo -e "\nCurrent branch [$cur_branch]"
    git-pull --ff --recurse-submodules
}
