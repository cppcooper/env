#!/usr/bin/bash
FUNCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FUNCDIR/scripting.bash
source $FUNCDIR/rng.bash

##################
## Mutex Functions

blockon() {
  if [ -z "$1" ] || [ "$(type -t $1)" != "function" ]
  then
    echo "blockon: error: invalid argument"
    return 1
  fi
  $@
  r="$?"
  save_cursor="\033[s"
  restore_cursor="\033[u"
  up_one_line="\033[1A"
  overwrite_line="\r                                                                      $up_one_line"
  if [ "$r" = "1" ]
  then
    echo -e "$@ waiting for other terminals$save_cursor"
    printf "$restore_cursor"
    until $@
    do
      printf "."
      sleep $(frng_range 0.01 0.5 0.005)
    done
    echo -e "$overwrite_line"
  fi
}

blockon_w() {
  if [ -z "$2" ] || [ "$(type -t $2)" != "function" ]
  then
    echo "blockon: error: invalid argument"
    return 1
  fi
  w=$1
  shift
  $@
  r="$?"
  s=1
  save_cursor="\033[s"
  restore_cursor="\033[u"
  up_one_line="\033[1A"
  overwrite_line="\r                                                                      $up_one_line"
  if [ "$r" = "1" ]
  then
    echo -e "$@ waiting for other terminals$save_cursor"
    printf "$restore_cursor"
    until $@
    do
      printf "."
      sleep $(frng_range 0.01 0.5 0.005)
      s=$((s+1))
      if (( s >= w ))
      then
        echo -e "$overwrite_line"
        debug_ "blockon_w: wait time expired"
        return 1
      fi
    done
    echo -e "$overwrite_line"
  fi
}

newlock() {
  if [ ! -z "$1" ]
  then
    if windows; then
      lock="/c/.tmp-lock-$1"
    else
      lock="/tmp/.tmp-lock-$1"
    fi
    if mkdir $lock > /dev/null 2>&1
    then
      return 0
    else
      #echo "Error: lock exists already"
      return 1
    fi
  else
    echo "Error: please provide a lock identifier."
    return 1
  fi
}

releaselock() {
  if [ ! -z "$1" ]
  then
    if windows; then
      lock="/c/.tmp-lock-$1"
    else
      lock="/tmp/.tmp-lock-$1"
    fi
    if [ -d "$lock" ]
    then
      debug_ "releasing lock"
      rm -rf $lock
      return 0
    else
      echo "Error: ${lock} does not exist, or is already released."
      return 1
    fi
  else
    echo "Error: please provide a lock identifier."
    return 0
  fi
}

debug_ parallel.bash ends
