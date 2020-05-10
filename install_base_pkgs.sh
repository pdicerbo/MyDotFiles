#!/bin/bash

echo -e "\n\tinit operations"
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc --utc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "ArchLinux" > /etc/hostname

echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1         localhost" >> /etc/hosts
echo "127.0.1.1   ArchLinux.localdomain	ArchLinux" >> /etc/hosts

echo -e "\n\tbase system upgrade"
# upgrade the system
pacman -Suy --noconfirm

echo -e "\n\tinstall X server packages"
# install X server
pacman -S --noconfirm xorg xorg-server xorg-apps

echo -e "\n\tinstall xfce-4 DE"
# install xfce-4 DE
pacman -S --noconfirm xfce4 xfce4-goodies

echo -e "\n\tinstall base user utilities"
# user utils
pacman -S --noconfirm sudo awesome conky picom rxvt-unicode xsel numlockx archey3 wget

echo -e "\n\tinstall base development utils"
# development utils
pacman -S --noconfirm gcc make cmake linux-headers perl python3 python-pip docker awk vim emacs

echo -e "\n\tenabling/starting docker service"
systemctl enable docker.service
systemctl start  docker.service

echo -e "\n\tadd new user"
useradd -m --groups root,wheel,docker pierluigi

echo -e "pierluigi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pierluigi

cp Xstuff/root_bashrc $HOME/.bashrc

echo -e "\n\tremember to set the new user password!"