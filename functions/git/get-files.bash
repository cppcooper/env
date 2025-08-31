#!/usr/bin/bash

function git-files(){
    pattern=$(echo $1 | sed 's/\./\\./g; s/*/.*/g;')
    cat \
        <(git status -uno | grep "$pattern" | awk -F':' '{print $2}') \
        <(git ls-files | grep "$pattern") \
        <(git ls-files --others --exclude-standard | grep "$pattern") \
        | awk '{$1=$1};{printf("%s\n",$0)}' | sort | uniq
    #  /x27 => '
};
