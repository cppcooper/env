#!/bin/bash

echo "mkinitcpio -c /etc/mkinitcpio.conf -g /boot/initramfs-linux.img"
mkinitcpio -c /etc/mkinitcpio.conf -g /boot/initramfs-linux.img

name=$(hostname)
if [[ $name =~ "Hannah" || $name =~ "Janus" ]]; then
    echo "mkinitcpio -c /etc/mkinitcpio-vfio.conf -g /boot/initramfs-linux-vfio.img"
    mkinitcpio -c /etc/mkinitcpio-vfio.conf -g /boot/initramfs-linux-vfio.img
    #systemctl enable select-xorg.conf.service
fi
