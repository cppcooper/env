#!/usr/bin/bash
FGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FGDIR/is-git-tree.bash

function parse_git_status {
    if we_are_in_git_work_tree
    then
    local ST=$(git status --short 2> /dev/null)
        if [ -n "$ST" ]
            then echo -n "+"
            else echo -n ""
        fi
    fi
}
