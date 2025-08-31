#!/usr/bin/bash
alias mkdir="mkdir --parents"
alias ls="ls --color=always --group-directories-first"
alias grep='grep --color=auto'
alias lsblk="lsblk --output MOUNTPOINTS,SIZE,NAME,PARTLABEL"
alias tree="tree -C"

alias dd="dd status=progress"
alias upgrade-system="pacman -Syu | tee -a ~/upgrade.log"
alias startway="XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland"
alias startw="dbus-run-session startplasma-wayland"
#alias reverse_sha_list=sha_list_reversed
#alias cmake-ming="cmake -G \"MinGW Makefiles\""
#alias cmake-msys="cmake -G \"MSYS Makefiles\""
#alias ssh-home="ssh 50.92.80.50 -p 63751"
