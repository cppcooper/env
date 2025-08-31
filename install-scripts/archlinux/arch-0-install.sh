#!/bin/bash
#install pacstrap to correct location

echo verify boot mode

echo ls /sys/firmware/efi/efivars
ls /sys/firmware/efi/efivars
echo

echo ip link
ip link
echo
echo

echo timedatectl set-ntp true
timedatectl set-ntp true
echo

echo hope the partitions are ready
read -p 'install partition (/dev/<input>): ' archpart
echo

echo mkfs.ext4 /dev/$archpart
mkfs.ext4 /dev/$archpart					#partition formatted
echo

echo cd /mnt
cd /mnt
echo "$(pwd)"
mkdir arch
echo 							#inside /mnt

mount PARTLABEL=archlinux /mnt/arch

echo "Getting Arch.."
echo pacstrap /mnt/arch base linux linux-headers linux-firmware nano inetutils git openssh sudo su gcc cmake ninja
pacstrap /mnt/arch base linux linux-headers linux-firmware nano inetutils git openssh sudo su gcc cmake ninja


#echo "chroot now, and continue.. remember to remount any extra partitions needed"
#arch-chroot /mnt/arch
