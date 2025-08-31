#!/usr/bin/bash
FUNCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FUNCDIR/scripting.bash

iprenew(){
    if windows;
    then
        ipconfig -release
        ipconfig -renew
    else
        dhcpcd -k
        dhcpcd
        ip add
    fi
}

debug_ network.bash ends
