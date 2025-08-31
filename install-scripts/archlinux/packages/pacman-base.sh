#!/bin/bash
path=$(realpath $0)
path=$(dirname $path)
source $path/.try.bash

echo "Core packages/utils"
pacman -Sy --needed --noconfirm \
    p7zip \
    dpkg \
    patch \
    pkgconf \
    openssh \
    seahorse \
    gnome-keyring \
    dmidecode \
    fakeroot || panykey
echo "Terminal"
pacman -Sy --needed --noconfirm \
    terminator \
    guake \
    man \
    sudo \
    tree \
    lsof ` # list open files` \
    nano \
    screen \
    pdftk `# pdf tool kit` \
    pdfgrep `# pdf grep` \
    ` #etherwake # WOL cli` \
    inetutils ` # common network programs` \
    neofetch ` # fancy system info` \
    nvme-cli ` # nvme drives` \
    smartmontools ` # SMART monitor tools` \
    bash-completion \
    nano-syntax-highlighting || panykey
echo "Storage related"
pacman -Sy --needed --noconfirm \
    cryptsetup \
    exfatprogs \
    nfs-utils \
    gparted || panykey
echo "Network stack"
pacman -Sy --needed --noconfirm \
    dhcpcd \
    nmap \
    bind \
    dnsmasq \
    iptables \
    tor \
    nyx \
    wol \
    ethtool \
    networkmanager || panykey
echo "Video stack"
pacman -Sy --needed --noconfirm \
    nvidia `# nvidia driver` \
    xf86-video-amdgpu `# AMD driver` \
    arandr `# front-end for xrandr` \
    autorandr `# simple cli for xrandr - also auto-detects config` \
    xorg-xinit \
    xorg-server \
    xorg-xrandr \
    xorg-xclock \
    clutter \
    wayland \
    waybar \
    plasma-wayland-session \
    plasma-wayland-protocols \
    qt5-wayland \
    qt6-wayland \
    glfw-wayland \
    xorg-xwayland \
    plasma-meta `# DESKTOP ENVIRONMENT` \
    noto-fonts \
    gnu-free-fonts \
    fontconfig || panykey
echo "Audio stack"
pacman -Sy --needed --noconfirm \
    bluez \
    bluez-utils \
    pulseaudio \
    pulseaudio-bluetooth \
    pavucontrol \
    beep || panykey
echo "Development stacks"
pacman -Sy --needed --noconfirm \
    git \
    gdb \
    gcc \
    gcc-fortran \
    ninja \
    make \
    automake \
    cmake \
    r \
    julia \
    python3 \
    perl \
    jdk-openjdk \
    openjdk-src \
    openjdk-doc \
    intellij-idea-community-edition \
    docker \
    docker-compose || panykey
echo "Libraries"
pacman -Sy --needed --noconfirm \
    glu \
    freeglut \
    bdf-unifont \
    zlib \
    sdl \
    sdl_image \
    sdl_ttf \
    perl-xml-libxml \
    perl-xml-libxslt \
    gcc-multilib || panykey
echo "Misc packages/utils"
pacman -Sy --needed --noconfirm \
    nemo \
    nemo-fileroller \
    nemo-terminal \
    gprename \
    kate \
    kwrite \
    gnome-system-monitor \
    hardinfo || panykey

#mate mate-extra

# pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-bluetooth pulsemixer pavucontrol-qt alsa-tools alsa-utils
