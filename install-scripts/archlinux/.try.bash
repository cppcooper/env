#!/bin/bash
function panykey(){
    echo
    echo "There was a problem"
    read -p "Press enter to continue"
    echo
}
function try(){
    if ! $1; then
        panykey
    fi
}
