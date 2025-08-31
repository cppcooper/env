#!/bin/bash
echo "We'll need git and ssh"
pacman -Sy git openssh

eval `ssh-agent`
ssh-add /tmp/bitbucket-key
cd /
git clone git@bitbucket.org:cppcooper/system.git .system
cd .system
git checkout lin-sys
git submodule init
git submodule update
