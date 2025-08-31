#!/usr/bin/bash

function git-count-loc-blame(){
    git ls-files -z $@ | xargs -0n1 git blame -w | sed -r "s/.*\((.*)\s[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}.*/\1/g" | sort -f | uniq -c | sort -n
}
