#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}" )"
#host=$(hostname) won't work in chroot
read -p "Enter host name:" host
./pacman-base.sh
./pacman-$host.sh
