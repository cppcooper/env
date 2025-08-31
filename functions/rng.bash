#!/usr/bin/bash
FUNCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FUNCDIR/scripting.bash

irng_range() {
  a="$1"
  b="$2"
  lim="$3"
  count="0"

  while :; do
    num=$(tr -dc '0-9\n' < /dev/random | grep -Pom1 "^\\d{${#a},${#b}}")
    if [[ "$num" -ge "$a" ]] && [[ "$num" -le "$b" ]]; then
      echo "$num"
      count="$((count + 1))"
      [[ "$count" -ge "$lim" ]] && break
    fi
  done
}

frng_range() {
  echo $(seq $1 $3 $2 | shuf | head -n1)
}

debug_ rng.bash ends
