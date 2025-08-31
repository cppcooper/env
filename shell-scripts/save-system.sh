#!/bin/bash
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# cd $DIR/systems/$host
host=$(hostname)
cd /mnt/system/backup/systems/$host

function save(){
    path="$1"

    if [[ -f "$path" ]]; then
        file="$(basename "$path")"
        dir="$(dirname "$path")"
        user=$(stat -c "%U" "/$path")
        group=$(stat -c "%G" "/$path")
        mkdir --parents "/backup/systems/$host/$dir"
        if cp --remove-destination --archive "/$path" "/backup/systems/$host/$path"; then
            echo "saved: \"/$path\""
            chown $user:$group "/backup/systems/$host/$path"
        else
            return 1;
        fi
    else
        echo "no such file: \"$file\""
    fi
}
count=0
for file in $(find * -not -type d -not -name "*~*"); do
    if save "$file"; then
        :
    else
        ((count++))
    fi
done

function fix-perm(){
    dir="$1"

    if [[ -d "$dir" ]]; then
        chown root:storage "$dir"
        chmod 770 "$dir"
    else
        echo "no such directory: \"$dir\""
    fi
}
for dir in $(find * -type d); do
    fix-perm "$dir"
done

echo "$count files skipped"
