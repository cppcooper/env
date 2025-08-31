#!/usr/bin/bash
ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

uPATH=""
if windows
then
    # the windows environment is lost to the sands of time.. this all needs redoing if we're ever to make use of this section
    # probably best to update the windows install scripts for 2025 or later
    uPATH="$uPATH:/c/tools/build/mingw-w64.x86_64-posix-seh/bin"
    uPATH="$uPATH:/c/tools/build/cmake/bin"
    uPATH="$uPATH:/c/tools/build/make/bin"
else
    # These seem pointless and redundant in 2025
    uPATH="/opt/maple2017/bin;$uPATH"
    uPATH="$HOME/bin:$uPATH"
    uPATH="$HOME/scripts:$uPATH"
    uPATH="$HOME/commands:$uPATH"
fi
# The stuff in these directories *probably* don't work on both linux/windows
uPATH="$ROOTDIR/bin:$uPATH"
uPATH="$ROOTDIR/shell-scripts:$uPATH"
uPATH="$ROOTDIR/commands:$uPATH"

# environment variables
export PATH="$uPATH:$PATH"
export EDITOR=nano
export MAKEFLAGS="-j8"
export HISTIGNORE=''
export HISTCONTROL=erasedups
export HISTFILESIZE=5000 #nbr of cmds on file
export HISTSIZE=1000 #nbr of cmds in memory
export HISTFILE="$HOME/.bash_history"
export HISTTIMEFORMAT="%Y-%m-%d %T "
export SHELLOPT #shell options, like functrace
#export QT_SCREEN_SCALE_FACTORS="1;1"

echo
echo "Environment loaded."
