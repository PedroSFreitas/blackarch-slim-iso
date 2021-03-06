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

# storing the system journal in RAM
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

# default releng configuration
sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

# enable useful services and display manager
enabled_services=('choose-mirror.service' 'lxdm.service' 'vboxservice.service')
systemctl enable ${enabled_services[@]}
systemctl set-default graphical.target

# create the user directory for live session
if [ ! -d /root ]; then
    mkdir /root
    chmod 700 /root && chown -R root:root /root
fi

# create root Desktop folder
mkdir -p /root/Desktop

# disable pc speaker beep
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

# disable network stuff
rm /etc/udev/rules.d/81-dhcpcd.rules
systemctl disable dhcpcd sshd rpcbind.service

# remove special (not needed) files
rm /etc/systemd/system/getty@tty1.service.d/autologin.conf
rm /root/{.automated_script.sh,.zlogin}

# setting root password
echo "root:blackarch" | chpasswd

# default shell
chsh -s /bin/zsh

# setup repository, add pacman.conf entry, sync databases
pacman -Sy --noconfirm
pacman-db-upgrade
pacman-key --init
# install BlackArch repository with default mirror (that's why the sed)
curl -s https://blackarch.org/strap.sh | \
    sed 's|  check_internet|  #check_internet|' | sh
pacman-key --populate blackarch archlinux

# font configuration
ln -sfv /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
ln -sfv /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
ln -sfv /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

# Arch Wiki symlink to Desktop
ln -sfv /usr/share/doc/arch-wiki/html/en/ "/root/Desktop/Arch Wiki Offline"

# installation and README files, symlink on Desktop
ln -sfv /usr/share/blackarch/README /root/Desktop/README

# xfce4 and more skel configuration to root but leaving original tar.gz
tar xvf "/etc/skel/config.tar.gz" -C "/root/"
tar xvf "/etc/skel/local.tar.gz" -C "/root/"
tar xvf "/etc/skel/mozilla.tar.gz" -C "/root/"

# radare2 configuration file
cp -rfv /etc/skel/radare2rc /root/.radare2rc

# gdb configuration file
cp -rfv /etc/skel/gdbinit /root/.gdbinit

# vim configuration file
cp -rfv /etc/skel/vim /root/.vim

# zshrc skell file
cp -rfv /etc/skel/zshrc /root/.zshrc

# disabling VirtualBox notification
sed -i "s|notify-send|echo|g" /usr/bin/VBoxClient-all

# adding URL symlink to Normal and Offline Installation page on the Arch Wiki
ln -sfv "/usr/share/blackarch/BlackArch Offline Installation.desktop" \
    /root/Desktop/
ln -sfv "/usr/share/blackarch/Arch Linux Installation.desktop" \
    /root/Desktop/
chmod a+x /root/Desktop/*.desktop

# extract wordlists and remove the tar file
tar xvf "/usr/share/wordlists/wordlists.tar.gz" -C "/usr/share/wordlists"
rm -rfv "/usr/share/wordlists/wordlists.tar.gz"

# adding useful cheatsheets
ln -sfv "/usr/share/cheatsheets" "/root/Desktop/Cheatsheets"

# unpacking postgres msf database
tar xvf "/etc/skel/postgres.tar.gz" -C "/var/lib/"

# install manual packages
pkgfold="/usr/share/blackarch/packages"
pkglist=('geany-themes-1.24-1-any.pkg.tar.xz')
for package in ${pkglist[@]}; do
    echo "[*] installing: ${package}"
    if ! pacman -U --force --needed --noconfirm "${pkgfold}/${package}"; then
        echo "[!] failed: ${package}"
    fi
done

