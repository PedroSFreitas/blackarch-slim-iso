#!/bin/bash

# exit on error and undefined variables
set -eu

# set locale
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# set timezone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# enabling all mirros
sed -i "s|#Server|Server|g" /etc/pacman.d/mirrorlist

# enable useful services and display manager
enabled_services=('choose-mirror.service' 'lxdm.service' 'vboxservice.service')
systemctl enable ${enabled_services[@]}
systemctl set-default graphical.target

# create the user directory for live session
if [ ! -d /root ]; then
    mkdir /root
    chmod 700 /root && chown -R root:root /root
    mkdir -p /root/Desktop
fi

# disable pc speaker beep
su -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf' root

# disable network stuff
rm /etc/udev/rules.d/81-dhcpcd.rules
systemctl disable dhcpcd sshd rpcbind.service

# remove special (not needed) files
su -c 'rm /etc/systemd/system/getty@tty1.service.d/autologin.conf' root
su -c 'rm /root/{.automated_script.sh,.zlogin}' root

# setting root password
su -c 'echo "root:blackarch" | chpasswd' root

# default shell
su -c 'chsh -s /bin/zsh' root

# font configuration
su -c 'ln -fs /etc/fonts/conf.avail/70-no-bitmaps.conf \
    /etc/fonts/conf.d' root
su -c 'ln -fs /etc/fonts/conf.avail/10-sub-pixel-rgb.conf \
    /etc/fonts/conf.d' root
su -c 'ln -fs /etc/fonts/conf.avail/11-lcdfilter-default.conf \
    /etc/fonts/conf.d' root

# installation and README files
su -c 'ln -sfv /usr/share/blackarch/install /root/Desktop/install' root
su -c 'ln -sfv /usr/share/blackarch/README /root/Desktop/README' root

# xfce4 skel configuration
su -c 'mkdir -p /root/.config/' root
su -c 'cp -rfv /etc/skel/xfce4/ /root/.config/' root

# setup repository, add pacman.conf entry, sync databases
su -c 'pacman -Syy --noconfirm' root
su -c 'pacman -Scc --noconfirm' root
su -c 'pacman-optimize' root
su -c 'pacman-db-upgrade' root
su -c 'pacman-key --init' root
su -c 'curl -s https://blackarch.org/strap.sh | sh' root
su -c 'pacman-key --populate blackarch archlinux' root

# disabling VirtualBox notification
su -c 'sed -i "s|notify|#notify|g" /usr/bin/VBoxClient-all' root

