#!/usr/bin/bash

#if declare -f fnexists > /dev/null;
#then
#  return 0
#fi

function debug_(){
  if ((0))
  then
    echo "$@"
  fi
}

fnexists(){
  declare -f $@ > /dev/null;
  return $?;
}

windows() { [[ -n "$WINDIR" ]]; }

haspriv(){
  if windows;
  then
    net session > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
      return 0; #true
    else
      return 1; #false
    fi
  elif [ "$(whoami)" != "root" ]
  then
    return 1; #false
  else
    return 0; #true
  fi
}

sourcedir(){
  debug_ "$@"
  for f in $(find "$@" -type f);
  do
    debug_ source $f
    source $f
  done
}

debug_ scripting.bash ends
