#!/bin/bash
path=$(realpath $0)
path=$(dirname $path)
source $path/.try.bash
exec 3>&1

echo "RAID"
pacman -Sy --needed --noconfirm \
    mdadm || panykey
echo "Internet Applications"
pacman -Sy --needed --noconfirm \
	transmission-cli \
	transmission-remote-gtk \
	synergy \
	evolution \
	firefox \
	discord \
	steam \
	hexchat || panykey
echo "Gaming Environments"
pacman -Sy --needed --noconfirm \
	wine \
	lutris \
	gameconqueror \
	scanmem || panykey
echo "Office utils"
pacman -Sy --needed --noconfirm \
	libreoffice-still \
	cups \
	atril \
	texlive-bin \
	texlive-core \
	texlive-latexextra || panykey
echo "Multimedia"
pacman -Sy --needed --noconfirm \
	vlc \
	mpv || panykey
echo "wine, \"more complete\""
pacman -Sy --needed --noconfirm \
    giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader || panykey
