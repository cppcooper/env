#!/usr/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Else, begin a new session
echo    " -New Bash Session-"
echo -e "   \e[43m\e[30m[$(date +%a) $(date +%H:%M:%S)]\033[0m"

# import bash functions from scripts
ROOTDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $ROOTDIR/functions/scripting.bash
sourcedir $ROOTDIR/config
sourcedir $ROOTDIR/functions
source $ROOTDIR/core-env.bash
source $ROOTDIR/core-shell.bash

echo "Shell profile loaded."
echo ""

########################
## New Terminal stuff ##
########################

# display daylight details for today at Latitude 49.2 (N.Sur.)
daylight -l 49.2

# display different details based on starting/current working directory
WDIR=$(pwd)
if [[ $WDIR = "/" ]]; then
    if ! haspriv; then
        # starting in / we want to show disk details and ask for elevated priveledges
        df -h
        su
    fi
elif [[ $WDIR =~ "project" ]]; then
    # format things if we're in a project directory
    ls -Aw50
else
    # regular directory listing for everywhere else
    ls
fi
