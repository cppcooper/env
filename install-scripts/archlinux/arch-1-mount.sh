#!/bin/bash

echo cd /mnt
cd /mnt
echo "$(pwd)"
echo 							#inside /mnt

read -p 'install directory: ' dir
echo $dir > var.dir

if [ ! -d $dir ]; then
  mkdir $dir 2>&1 | grep -v "File exists"
fi
echo 							

echo "mounting devices..."

echo mount PARTLABEL=archlinux /mnt/$dir
mount PARTLABEL=archlinux /mnt/$dir 2>&1 | grep -v "already mounted"		#mount point secured

mkdir /mnt/$dir/efi 2>&1 | grep -v "File exists"
mkdir /mnt/$dir/home 2>&1 | grep -v "File exists"
mkdir /mnt/$dir/.system 2>&1 | grep -v "File exists"
mkdir /mnt/$dir/env 2>&1 | grep -v "File exists"
mkdir /mnt/$dir/data 2>&1 | grep -v "File exists"

echo mount PARTLABEL=EFI /mnt/$dir/efi
mount PARTLABEL=EFI /mnt/$dir/efi 2>&1 | grep -v "already mounted"

echo mount PARTLABEL=system /mnt/$dir/.system
mount PARTLABEL=system /mnt/$dir/.system 2>&1 | grep -v "already mounted"
mount --bind /mnt/$dir/.system/bash-env/ /mnt/$dir/env 2>&1 | grep -v "already mounted"
echo "ln -s /env/.exec-root.bash /mnt/$dir/root/.bashrc"
ln -s /env/.exec-root.bash /mnt/$dir/root/.bashrc 2>&1 | grep -v "File exists"
echo "ln -s /env/.exec-root.bash /mnt/$dir/root/.bash_profile"
ln -s /env/.exec-root.bash /mnt/$dir/root/.bash_profile 2>&1 | grep -v "File exists"

echo mount PARTLABEL=home /mnt/$dir/home
mount PARTLABEL=home /mnt/$dir/home 2>&1 | grep -v "already mounted"

echo mount PARTLABEL=data /mnt/$dir/data
mount PARTLABEL=data /mnt/$dir/data 2>&1 | grep -v "already mounted"

echo "Mounting complete"

