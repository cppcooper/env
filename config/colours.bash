#!/usr/bin/bash
#esc="\033"
invert="\[\033[7m\]"
blink="\[\033[5m\]"
underlined="\[\033[4m\]"
dim="\[\033[2m\]"
bright="\[\033[1m\]"
clear="\[\033[0m\]"

cmdtime="\033[1;36m" # colors for trap DEBUG, timestamp before command runs
ps1time="\033[35m[\D{%a %T}]$clear" # ps1 timestamp in case I ever need that again
