#!/bin/bash
read -p 'Please enter the hostname:' name
echo $name > /etc/hostname
echo "Restoring saved files for $name"
echo mount PARTLABEL=${name,,} /restore
mkdir /restore
mount PARTLABEL=${name,,} /restore

/env/shell-scripts/restore-system.sh

