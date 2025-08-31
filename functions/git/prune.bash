#!/usr/bin/bash

function git-prune(){
    git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done
}
