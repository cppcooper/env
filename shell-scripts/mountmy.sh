#!/bin/bash

echo "mounting devices..."

echo mkdir --parents /restore
mkdir --parents /restore
echo mkdir --parents /.system
mkdir --parents /.system
echo mkdir --parents /env
mkdir --parents /env
echo mkdir --parents /data
mkdir --parents /data
echo mkdir --parents /data/documents/personal
mkdir --parents /data/documents/personal
echo mkdir --parents /data/documents/school
mkdir --parents /data/documents/school
echo mkdir --parents /data/documents/work
mkdir --parents /data/documents/work

host=$(hostname)
echo "mount PARTLABEL=${host,,} /restore"
mount PARTLABEL=${host,,} /restore 2>&1 | grep -v "already mounted"

echo mount PARTLABEL=system /.system
mount PARTLABEL=system /.system 2>&1 | grep -v "already mounted"

mount --bind /.system/bash-env/ /env 2>&1 | grep -v "already mounted"
echo "ln -s /env/.exec-root.bash /root/.bashrc"
ln -s /env/.exec-root.bash /root/.bashrc 2>&1 | grep -v "File exists"
echo "ln -s /env/.exec-root.bash /root/.bash_profile"
ln -s /env/.exec-root.bash /root/.bash_profile 2>&1 | grep -v "File exists"

echo mount PARTLABEL=data /data
mount PARTLABEL=data /data 2>&1 | grep -v "already mounted"
echo mount PARTLABEL=personal /data/documents/personal
mount PARTLABEL=personal /data/documents/personal 2>&1 | grep -v "already mounted"
echo mount PARTLABEL=school /data/documents/school
mount PARTLABEL=school /data/documents/school 2>&1 | grep -v "already mounted"
echo mount PARTLABEL=work /data/documents/work
mount PARTLABEL=work /data/documents/work 2>&1 | grep -v "already mounted"

echo "Mounting complete"

