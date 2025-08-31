#!/usr/bin/bash
complete -W "--ff --no-rebase --branch" "git-pull"
complete -o default "sublime"
complete -o default "git-reset"
complete -F _robokill robokill
#complete -F _find find
function _robokill(){
    if [[ -z $2 ]]
    then
        return 1
    fi
    COMPREPLY=($(compgen -W "$(ps x | awk '{print $5}' | grep $2)"))
}

#function _find(){
#    if [[ -z $2 ]]
#    then
#        return 1
#    fi
#    COMPREPLY=($(compgen -W "$(man find | awk '{print $1}' | grep - | grep $2)"))
#}

# $1 - command being run
# $2 - search term
# $3 - segment before search term
# compgen -W {wordlist} {word}
#    {word} is a filter on {wordlist}, words beginning with {word} are shown
# autocompletion can occur if the words in {wordlist} begin with $2


# complete -F _pacmanSrch pacman
# function _pacmanSrch(){
#     if [[ -z $2 ]]
#     then
#         return 1
#     else
#         if [[ "$3" == "-Rs" ]]
#         then
#             COMPREPLY=($(compgen -W "$(pacman -Qs $2 | cut -d' ' -f1 | cut -d'/' -f2 | egrep ^$2)"))
#         else
#             COMPREPLY=($(compgen -W "$(pacman -Ss $2 | cut -d' ' -f1 | cut -d'/' -f2 | egrep ^$2)"))
#         fi
#     fi
# }

# bash completion V2 for gh                                   -*- shell-script -*-

# ex: ts=4 sw=4 et filetype=sh
