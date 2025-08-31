#!/bin/bash
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd /restore

function restore(){
    path="$1"

    if [[ -f "$path" ]]; then
        file="$(basename "$path")"
        dir="$(dirname "$path")"
        mkdir --parents "/$dir"
        if cp --preserve=all "./$path" "/$path"; then
            echo "wrote: \"/$path\""
        else
            return 1;
        fi
    else
        echo "no such file: \"$path\""
    fi
}
count=0
jcount=0
for file in $(find * -not -type d); do
    if restore "$file"; then
        ((jcount++))
    else
        ((count++))
    fi
done
echo "$jcount files restored, $count files skipped"
