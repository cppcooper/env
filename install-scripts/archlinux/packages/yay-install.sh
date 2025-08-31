#!/bin/bash
rtdir="$(dirname "${BASH_SOURCE[0]}" )"
echo $rtdir

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

yay --save --answerclean n --noeditmenu --cleanafter --noremovemake --sudoloop --noredownload --norebuild
