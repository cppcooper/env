#!/bin/bash
git clone https://github.com/cppcooper/daylight.git /tmp/daylight
cd /tmp/daylight
mkdir build
cd build
cmake .. -G Ninja
ninja install
/.system/install-scripts/archlinux/packages/pacman-all.sh
