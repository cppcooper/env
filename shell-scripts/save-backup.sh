#!/bin/bash
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# cd $DIR/systems/

# todo: accept one optional arg (a file listing what file to create a backup of)
#  destination /nas/backup/user-files/$user/$file_list[$idx++]
# if no args, check has root access
#  perform system backup
#  destination /nas/backup/systems/$hostname/
#  retrieve new copies of destination files (relative paths -> absolute paths)
# if no root access, exit -1


if ! haspriv; then
   echo "

if stat /nas/backup/systems/ &> /dev/null;
then
    cd /home/system/backup/systems
    dest="/data/array/backup/systems"

    function save(){
        path="$1"

        if [[ -f "$path" ]]; then
            file=$(basename "$path")
            dir=$(dirname "$path")
            mkdir --parents "$dest/$dir"
            chown root:storage "$dest/$dir"
            chmod 770 "$dest/$dir"
            if cp --archive --remove-destination "./$path" "$dest/$path"; then
                echo "saved backup:  \"$path\""
            else
                return 1;
            fi
        else
            echo "no such file: \"$file\""
        fi
    }
    function fix-perm(){
        dir="$1"

        if [[ -d "$dir" ]]; then
            chown root:storage "$dest/$dir"
            chmod 770 "$dest/$dir"
        else
            echo "no such directory: \"$dir\""
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

    for dir in $(find * -type d); do
        fix-perm "$dir"
    done
    echo
    echo "directory permissions set {root:storage;770}"
    echo "$count files skipped"
else
    echo "Missing /data/array/backup/systems"
fi
