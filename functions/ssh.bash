#!/usr/bin/bash
FUNCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FUNCDIR/scripting.bash

ssh-get-agents() {
  if windows; then
    tasklist //V | grep ssh-agent | grep $(whoami)
  else
    ps x | grep ssh-agent | grep -v grep
  fi
}

get-pid() {
  if windows; then
    awk '{print $2}'
  else
    awk '{print $1}'
  fi
}

ssh-kill-agent(){
  ssh-get-agents
  for pid in $(ssh-get-agents | get-pid)
  do
    if windows; then
      taskkill //F //PID $pid
    else
      echo kill -9 $pid
      kill -9 $pid
    fi
  done
}

ssh-print-connection-info(){
  echo $SSH_AUTH_SOCK
  if windows;then
    echo Agent winpid $(ps | grep $SSH_AGENT_PID | grep -v grep | awk '{print $4}')
  fi
  echo Agent pid $SSH_AGENT_PID
  echo Active keys
  echo -----------
  ssh-add -l
}

ssh-connect-agent(){
  if [ -f ~/.ssh/agent.env ]
  then
    debug_ "injecting agent.env"
    . ~/.ssh/agent.env 2>&1 >/dev/null
    #print-ssh-connection-info
  else
    debug_ "agent.sh doesn't exist"
    touch ~/.ssh/agent.env
    #echo "Critical Error: ~/.ssh/agent.sh does not exist"
  fi
}

ssh-start-agent(){
  debug_ "start_ssh_agent arguments: '$@'"
  if [[ "$@" != '--keep' ]]
  then
    debug_ "killing existing agents"
    if [[ "$@" == '--silent' ]]
    then
      ssh-kill-agent &> /dev/null
    else
      ssh-kill-agent
    fi
  else
    debug_ "keeping existing agents"
  fi
  ssh-agent > ~/.ssh/agent.env
  #chmod +x ~/.ssh/agent.sh
  ssh-connect-agent #run it
  ssh-reformat-agentinfo
}

ssh-reformat-agentinfo(){
  Line1="SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;"
  Line2="SSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AGENT_PID;"
  if windows
  then
    export SSH_AGENT_WINPID=$(ps | grep $SSH_AGENT_PID | grep -v grep | awk '{print $4}')
    Line3="SSH_AGENT_WINPID=$SSH_AGENT_WINPID; export SSH_AGENT_WINPID;"
  fi
  Line4="echo Agent winpid $SSH_AGENT_WINPID;"
  Line5="echo Agent pid $SSH_AGENT_PID;"
  debug_ "$Line1\n$Line2\n$Line3\n$Line4\n$Line5\n"
  printf "$Line1\n$Line2\n$Line3\n$Line4\n$Line5\n" > ~/.ssh/agent.env
}

debug_ ssh.bash ends
