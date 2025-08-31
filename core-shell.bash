#!/usr/bin/bash
# shell commands, history, PS1, PS2
ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

#########################
##### .bash_history #####
#########################

# shell options
shopt -s histverify
shopt -s histappend
shopt -s extglob
shopt -s cmdhist

#####################
## shell  commands ##
#####################

export BASH_COMMAND #current command executed by user or a trap
export lastCMD

function post-command() {
    dcolor="\033[1;34m"
    hcolor="\033[1;33m$(whoami)@\033[0;33m$(hostname)"
    branch="\033[1;2;34m\033[2;34m`__git_ps1`"
    echo -n -e "\033[1;2;5;31m  "
    timestamp
    #echo -e "[$(date +%a) $(date +%H:%M:%S)]\e[0m"
    echo
    if haspriv
    then
        echo -e "$dcolor$(realpath .)\033[0m $branch"
    else
        echo -e "$hcolor $dcolor$(realpath .) $branch"
    fi
    make_history
}
function pre-command() {
    export lastCMD=$BASH_COMMAND #simpler and quicker version! avoid 'sync' and 'history -r' which are time consuming!
    if [ "$BASH_COMMAND" != "$PROMPT_COMMAND" ] #avoid logging unexecuted commands after Ctrl-C or Empty+Enter
    then
        echo -n -e "$cmdtime" # configure colour for timestamp
        timestamp
    fi
}

    #####################################################
    # PROMPT_COMMAND is executed before PS1 is printed. So we can use it to prepare the shell in certain ways
    #  We can insert a `trap fn DEBUG` to execute a function before the next command (ie. on the next DEBUG signal)
    #  We can insert a command, that will run after a user command has been run. Or before it - and the PS1 printing - depending on your perspective.
    #####################################################
    # So what we do is
    #  1. we start with a command that needs to run after the last command (ie. before the next PS1)
    #  2. we finish with the trap so it does not capture the other command we are inserting
    #  3. we ask for 'pre-command; trap DEBUG' to execute, so we get what we want only once. The next PROMPT_COMMAND can reinstate it
export PROMPT_COMMAND="post-command;trap 'pre-command;trap DEBUG' DEBUG"
    # I have attempted to just have "post;pre" but can't seem to form the functions adequately. It usually ends in duplicate timestamps.


#if [ -z $REMOTE ]
#then
#  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
#    export REMOTE=1
    #SESSION_TYPE=remote/ssh
#  else
#    case $(ps -o comm= -p $PPID) in
#      sshd|*/sshd) export REMOTE=1;;
#    esac
#  fi
#  if [ -n "$REMOTE" ]
#  then
#    trap "echo mem > /sys/power/state;exit" EXIT
#  else
#    trap "session-cleanup;exit" EXIT
#  fi
#fi
