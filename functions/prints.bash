#!/usr/bin/bash
FUNCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $FUNCDIR/scripting.bash

print_fcolors(){
  for k in {30..39}; do
    echo -e "\033[0m\033[7;${k}mcolor: $k";
    for i in 0 1 2; do
      for j in $(seq $(($i+1)) 3); do
        echo -e "\033[0m\033[$i;$j;${k}m $i;$j;$k";
      done
    done
    for i in 4 5 7; do
      echo -e "\033[0m\033[$i;${k}m $i;$k";
    done
  done
  echo -n -e "\033[0m"
}

print_bcolors(){
  for k in {40..49}; do
    echo -e "\033[0m\033[7;${k}mcolor: $k";
    for i in 0 1 2; do
      for j in $(seq $(($i+1)) 3); do
        echo -e "\033[0m\033[$i;$j;${k}m $i;$j;$k";
      done
    done
    for i in 4 5 7; do
      echo -e "\033[0m\033[$i;${k}m $i;$k";
    done
  done
  echo -n -e "\033[0m"
}

show_colorsn(){
  for code in {0..$1}; do echo -e "\e[${code}m $code: Test"; done
}

debug_ prints.bash ends
