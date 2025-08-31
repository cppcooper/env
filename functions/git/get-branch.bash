#!/usr/bin/bash

function parse_git_branch {
    if we_are_in_git_work_tree
    then
        local BR=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null)
        if [ "$BR" == HEAD ]
        then
            local NM=$(git describe --tags 2> /dev/null)
            if [ ! -z "$NM" ]
            then
                echo -n "$NM"
            else
                local NM2=$(git name-rev --name-only HEAD 2> /dev/null)
                if [ "$NM2" != undefined ]
                then
                    echo -n "$NM2"
                else
                    echo -n "$(git rev-parse --short HEAD 2> /dev/null)"
                fi
            fi
        else
            echo -n $BR
        fi
    fi
}
