#!/bin/bash
echo $(pwd)
echo $0
path=$(realpath $0)
path=$(dirname $path)
source $path/.try.bash

#yay -Sy snapd || panykey
#yay -Sy xnviewmp || panykey
yay -Sy monodevelop-git || panykey
yay -Sy all-repository-fonts || panykey
yay -Sy \
	flameshot \
	gconf \
	stacer \
	hydrapaper-git --overwrite '*' || panykey

yay -Sy \
	`# glow` \
	clion \
	clion-jre \
	bitwise \
	tor-browser \
    `# etherwake` \
	`# keepnote` \
	`# edrawmax` \
	sublime-merge \
	sublime-text-4 \
	rstudio-desktop-bin --overwrite '*' || panykey

#yay -Sy p3x-onenote menulibre
#yay -Sy rcraid-dkms
#vuurmuur screencloud
#monodevelop-git

# yay -Sy ovmf-git
# sudo rm /var/lib/libvirt/images/ovmf_vars_x64.bin
# sudo ln -s /usr/share/ovmf/ovmf_vars_x64.bin /var/lib/libvirt/images/ovmf_vars_x64.bin
# sudo chmod 644 /var/lib/libvirt/images/ovmf_vars_x64.bin

