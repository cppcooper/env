#!/bin/bash
DIR=$(dirname "${BASH_SOURCE[0]}")

echo "We need to configure a few things."
cd $DIR
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Canada/Pacific /etc/localtime
hwclock --systohc

echo "If you did not restore settings, please go and modify/implement any files you need."
echo "eg. /etc/fstab, /etc/locale.conf, /etc/X11/xorg.d/xorg.conf, /etc/hosts, etc."
read -p "press return to continue.."
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "Install a bootloader if you need one right around now"
#sudo cp /usr/share/ovmf/ovmf_vars_x64.bin /var/lib/libvirt/images/ovmf_vars_x64.bin
