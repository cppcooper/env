#!/usr/bin/bash
FUNCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FUNCDIR/scripting.bash

##########
## History

timestamp() {
    echo -e "[$(date +%a) $(date +%H:%M:%S)]\e[0m"
}

session-cleanup(){
    rm /tmp/*history* &> /dev/null
}

make_history() {
    lock="/tmp/history.lock"
    pid=$(ps -p $$ | grep -v PID | awk '{print $1}')

    # should result in synchronized terminal histories
    history -a
    history -c
    history -r

    # copy history file
    cat $HISTFILE > /tmp/history-$pid-original

    # reverse combined history
    tac /tmp/history-$pid-original > /tmp/history-$pid-reversed

    # filter history
    cat /tmp/history-$pid-reversed | awk '!seen[$0]++' | pcre2grep -M "[^#\s].*\s#\d{10}" > /tmp/history-$pid-reversed2
    tac /tmp/history-$pid-reversed2 | pcre2grep -M "#\d{10}\s[^#\s].*" > /tmp/history-$pid

    # get a file lock, and rewrite $HISTFILE
    (
        flock -x 200
        cat /tmp/history-$pid > $HISTFILE
    ) 200>$lock
    rm $lock &> /dev/null

    # replace this terminal's history with filtered version
    history -c
    history -r
    cmd=$(echo $lastCMD | xargs)
    if [[ "$cmd" == history[[:space:]]-d* ]]
    then
        # if the user is deleting an entry, we have to re-run their command.. otherwise it is bypassed by our above merge (presumably history -a)
        $lastCMD
        history -w
    fi
}

histdel_range(){
  for h in $(seq $1 $2 | tac); do
    history -d $h
  done
}

histdeln(){
  a="$1"
  b=$(history | tail -1 | awk '{print $1}')
  histdel_range $((b-a)) $b
}

histdelto(){
  a="$1"
  b=$(history | tail -1 | awk '{print $1}')
  histdel_range $((a+1)) $b
}

reloadhistory() {
  history -c
  history -r
}

purgehistory() {
#  return 1
#  echo "major malfunction"
  purgehistory_core
  return $?
}

phgit(){
  purgehistory_core '(git ((add|reset|diff|log|checkout( HEAD| --)) (?!(`|\$))|commit|status|tag|push|branch))'
}

debug_ history.bash ends
