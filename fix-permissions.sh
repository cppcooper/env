#!/bin/bash
if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root."
    exit 1;
fi
echo "Correcting ownerships.."

echo "chown root:storage all directories in /restore"
find /restore -type d -exec chown root:storage {} \;
echo "chown root:storage /env -R"
chown root:storage /env -R
echo "chown root:root /env/*root*"
find /env -iname "*root*" -exec chown root:root {} \;


#echo "chown root:developer /data/dev -R"
#chown root:developer /data/dev -R
#find /data/* -maxdepth 0 -not -type l -not -name "dev" -exec chown :storage {} -R \;

echo "Correcting permissions.."

echo "chmod 2700 /root -R"
chmod 2700 /root -R


 echo "fixing up /env"

 echo "0750 all"
 find /env -exec chmod 0750 {} \;

 echo "2755 directories"
 find /env -type d -exec chmod 2755 {} \;

 echo "0755 subdirectory files"
 find /env/bin -type f -exec chmod 0755 {} \;
 find /env/commands -type f -exec chmod 0755 {} \;
 find /env/config -type f -exec chmod 0755 {} \;
 find /env/functions -type f -exec chmod 0755 {} \;
 find /env/shell-scripts -type f -exec chmod 0755 {} \;

 echo
 echo "shell security"
 chmod 0755 .bash-core-env.bash
 chmod 0755 .bash-core-shell.bash
 chmod 0755 .exec-user.bash
 chmod 0700 .exec-root.bash

 chmod 0700 fix-permissions.sh
 chmod 0700 link-root.sh
 chmod 0700 link-user.sh

echo "Done."
echo

ls -al --color=always --group-directories-first /env

#find /data/* -maxdepth 0 -not -type l -type d -exec chmod 770 {} -R \;
#find /data/* -maxdepth 0 -not -type l -not -type d -exec chmod ug+rw {} -R \;
