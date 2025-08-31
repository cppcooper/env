#!/bin/bash
echo "Set root password:"
passwd
groupadd -g 201 sudo
groupadd -g 8002 media
#groupadd -g 1003 decrypt
groupadd -g 1088 developer

useradd -G sudo,audio,video,storage,developer     josh
#useradd -G      audio,video,storage,wheel         admin
#useradd -G      audio,video,storage               tv

echo "Set password for user josh:"
passwd josh
#echo Enter the password for user admin
#passwd admin
#echo Enter the password for user tv
#passwd tv
/env/link-user.sh josh
/env/link-root.sh

echo "storage guid: $(cat /etc/group | grep storage)"
