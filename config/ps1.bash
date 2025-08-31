#!/bin/bash
CONFDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $CONFDIR/colours.bash
source $ROOTDIR/functions/scripting.bash
sourcedir $ROOTDIR/functions/git

#########################
### PS1 configuration
#########################

if ! fnexists __git_ps1
then
    __git_ps1() {
        status="$(parse_git_status)"
        branch="$(parse_git_branch)"
        if [ ! -z "$branch" ]
        then
            printf "($status$branch)"
        fi
    }
fi

if haspriv
then
    prompt="\[\033[0;31m\]\h#"
else
    prompt="\[\033[0;33m\]$"
fi                    # $$clear was buggy

#there is a single character unaccounted for, so I counted a space that shouldn't be counted - on the prompt line.
PS1="$prompt$clear "
PS2="> "

debug_ ps1.bash ends
