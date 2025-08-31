#!/usr/bin/bash
ROOTDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
echo    " -New Bash Session-"
echo -e "   \e[43m\e[30m[$(date +%a) $(date +%H:%M:%S)]\033[0m"
source $ROOTDIR/core-env.bash
source $ROOTDIR/core-shell.bash
echo "Shell profile loaded."
echo ""
lsblk

