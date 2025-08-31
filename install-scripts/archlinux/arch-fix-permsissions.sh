#!/bin/bash
if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root."
    exit 1;
fi
echo "Correcting ownerships.."

echo "Fixing (some) system directories"
echo "chown root:storage all directories in /restore"
find /restore -type d -exec chown root:storage {} \;
echo "chown root:storage /env -R"
chown root:storage /env -R
echo "chown root:root /env/*root*"
find /env -iname "*root*" -exec chown root:root {} \;
echo "chown root:storage /opt -R"
chown root:storage /opt -R

echo "Fixing user files"
echo "chown user:user /home/user -R"
chown josh:josh /home/josh -R
echo "chown root:storage /mnt/documents -R"
chown root:storage /mnt/documents -R
echo "chown josh:josh /mnt/documents/personal/josh -R"
chown josh:josh /mnt/documents/personal/josh -R
echo "chown josh:storage /mnt/documents/school -R"
chown josh:storage /mnt/documents/school -R

#echo "chown root:developer /data/dev -R"
#chown root:developer /data/dev -R
#find /data/* -maxdepth 0 -not -type l -not -name "dev" -exec chown :storage {} -R \;

echo "Correcting permissions.."

echo "Fixing (some) system directories"
echo "chmod 2775 /opt -R"
chmod 2775 /opt -R
echo "find /opt -not -type d -exec chmod 0775 {} \;"
find /opt -not -type d -exec chmod 0775 {} \;

echo "chmod 2700 /root -R"
chmod 2700 /root -R
echo "chmod 770 /env -R"
chmod 770 /env -R
echo "chmod 2775 -R all directories in /env"
find /env -type d -exec chmod 2775 {} -R \;
echo "find /env -not -type d -exec chmod 0775 {} \;"
find /env -not -type d -exec chmod 0775 {} \;
echo "chmod 700 /env/*root*"
find /env -iname "*root*" -exec chmod 700 {} \;
echo "chmod g-w /env/.*.bash"
find /env -iname ".*.bash" -exec chmod g-w {} \;
echo "chmod g-w /env/ssh.bash /env/link-user.sh"
chmod g-w /env/ssh.bash
chmod g-w /env/link-user.sh

echo "Fixing user files"
echo "find /home/josh -type d -exec chmod 2770 {} \;"
find /home/josh -type d -exec chmod 2770 {} \;
echo "find /home/josh -not -type d -exec chmod 770 {} \;"
find /home/josh -not -type d -exec chmod 770 {} \;
echo "find /mnt/documents/personal/josh -type d -exec chmod 2770 {} \;"
find /mnt/documents/personal/josh -type d -exec chmod 2770 {} \;
echo "find /mnt/documents/personal/josh -not -type d -exec chmod 770 {} \;"
find /mnt/documents/personal/josh -not -type d -exec chmod 770 {} \;
echo "find /mnt/documents/school -type d -exec chmod 2770 {} \;"
find /mnt/documents/school -type d -exec chmod 2770 {} \;
echo "find /mnt/documents/school -not -type d -exec chmod 770 {} \;"
find /mnt/documents/school -not -type d -exec chmod 770 {} \;

#find /data/* -maxdepth 0 -not -type l -type d -exec chmod 770 {} -R \;
#find /data/* -maxdepth 0 -not -type l -not -type d -exec chmod ug+rw {} -R \;
