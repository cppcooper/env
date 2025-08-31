#!/bin/bash
path=$(realpath $0)
path=$(dirname $path)
source $path/.try.bash

systemctl enable systemd-timesyncd.service || panykey
systemctl enable systemd-networkd-wait-online.service || panykey
systemctl enable NetworkManager-wait-online.service || panykey
systemctl enable tor.service || panykey
systemctl enable transmission.service || panykey

#systemctl start cups.service || panykey
#cupsenable direct || panykey
systemctl enable sshd || panykey
systemctl enable dhcpcd || panykey
#systemctl enable libvirtd.service || panykey
#systemctl enable org.cups.cupsd.socket || panykey

systemctl enable nfs-server || panykey
#systemctl enable libvirtd || panykey
systemctl enable bluetooth || panykey

systemctl start sshd || panykey
systemctl start dhcpcd || panykey
systemctl start tor.service || panykey
systemctl mask mdmonitor || panykey
#systemctl enable snapd.socket || panykey
systemctl enable enable-wol.service
