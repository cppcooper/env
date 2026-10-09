#!/usr/bin/bash
CONFDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $ROOTDIR/functions/scripting.bash
source $ROOTDIR/functions/ssh.bash

if ! windows; then
  lock="/tmp/.lock-sshbash"
  exec 3>$lock
  flock --timeout 300 3 || exit 1
fi

debug_ "debug mode on"
if [ -z "$CYGWIN_SHELL" ] && [ -z "$MSYS_SHELL" ]
then
  sshcount=0
  # To ensure we connect across ttys and even if we didn't run it at the tty level
  # we need to check a number of things. (and that it works on windows)
  # Check:
  #   that there is at least one agent running
  #   that the running agent is referenced inside agent.env
  # If it is not the agent referenced inside agent.env the user may have multiple running
  for pid in $(ssh-get-agents | get-pid)
  do
    ((sshcount++))
  done
  debug_ "ssh-agent count: $sshcount"
  if ((sshcount == 0))
  then
    debug_ "user has no ssh-agents open"
    ssh-start-agent --keep
                   #--keep micro-optimization
  else
    debug_ "attempting to connect to the ssh-agent referenced inside agent.env"
    ssh-connect-agent 1> /dev/null
                   #  we want to display the connection info at the end, so we save it
    if ssh-add -l 2>&1 | grep "Error" &> /dev/null
    then
      debug_ "ssh agent not connected or started"
      ssh-start-agent 1> /dev/null
    elif windows
    then
      debug_ "Okay, we are connected to an agent but let's check that it is the PID inside agent.env"
      PID=0
      for pid in $(get-agents | get-pid)
      do
        if [[ $pid == $SSH_AGENT_WINPID ]]
        then
          debug_ "PID from agent.env is running"
          PID=$pid
          break
        fi
      done
      if ((PID == 0))
      then
        debug_ "Could not find PID from agent.env"
        ssh-start-agent --keep 1> /dev/null
      fi
    fi
    ssh-print-connection-info
  fi
fi
if ! windows; then
  rm -rf $lock
  flock -u 3
fi
#unset -f get-agents
#unset -f get-pid
debug_ ssh.bash ends
