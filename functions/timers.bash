#!/usr/bin/bash
FUNCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FUNCDIR/scripting.bash

offtimer(){
  sleep $1;
  psshutdown.exe -d -t 0 -accepteula;
  #rundll32.exe powrprof.dll,SetSuspendState 0,1,0
}

remindme(){
    countdown $1
    notify-send "$2" "$3"
    xmessage "$2: $3"
    beep
}

debug_ timers.bash ends
