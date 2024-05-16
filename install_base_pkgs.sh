#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo -e "\n\tUsage\n\t  $0 [username] [vbox|...]\n\n\tif vbox is passed, some other steps will be performed"
    exit 2
fi

echo -e "\n\tinit operations\n"

# set localtime
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc --utc

# choose locale language
# by commenting the undesired choice
LOCALE="it_IT.UTF-8"
# LOCALE="en_US.UTF-8"

echo "$LOCALE UTF-8" > /etc/locale.gen
locale-gen

echo "LANG=$LOCALE" > /etc/locale.conf

# set hostname and hosts
echo "ArchLinux" > /etc/hostname

echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1         localhost" >> /etc/hosts
echo "127.0.1.1   ArchLinux.localdomain	ArchLinux" >> /etc/hosts

# adjust time
timedatectl set-ntp true

echo -e "\n\tbase system upgrade\n"
# upgrade the system
pacman -Suy --noconfirm

echo -e "\n\tinstall X server packages\n"
# install X server
pacman -S --noconfirm xorg xorg-server xorg-apps

echo -e "\n\tinstall xfce-4 DE\n"
# install xfce-4 DE
pacman -S --noconfirm xfce4 xfce4-goodies

echo -e "\n\tinstall network utilities\n"
pacman -S --noconfirm iw wpa_supplicant dialog dhcpcd netctl openssh

# install grub
echo -e "\n\tinstall GRUB bootloader\n"
pacman -S --noconfirm grub dosfstools os-prober fuse2
grub-install --target=i386-pc /dev/sda
sed -i 's/ quiet//' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "\n\tinstall base user utilities\n"
# user utils
pacman -S --noconfirm git sudo awesome conky picom rxvt-unicode urxvt-perls xsel numlockx archey3 wget inetutils

echo -e "\n\tinstall base development utils\n"
# development utils
pacman -S --noconfirm gcc make cmake linux-headers perl python3 python-pip docker docker-compose awk vim emacs chromium

echo -e "\n\tinstall some other utilities\n"
# development utils
pacman -S --noconfirm ksnip poppler

echo -e "\n\tinstall some fonts\n"
pacman -S --noconfirm ttf-dejavu ttf-dejavu-nerd noto-fonts gnu-free-fonts ttf-anonymous-pro

echo -e "\n\tinstall audio utils\n"
pacman -S --noconfirm alsa-utils pulseaudio pulseaudio-alsa pavucontrol

echo -e "\n\tenabling/starting docker service\n"
systemctl enable docker.service
systemctl start  docker.service

if [[ $2 -eq "vbox" ]] ; then
    echo -e "\n\tinstall virtualbox utils\n"
    pacman -S --noconfirm virtualbox-guest-utils

    echo -e "\n\tenabling/starting vbox service\n"
    systemctl enable vboxservice.service
    systemctl start  vboxservice.service

    echo -e "\n\tadding default shared folder into /etc/fstab\n"
    echo "shared  /media/sf_shared  vboxsf  uid=1000,gid=1000,rw,dmode=700,fmode=600,noauto,x-systemd.automount" >> /etc/fstab
else
    echo -e "\n\tcontinue with default installation\n"
fi

input_user=$1

echo -e "\n\tadd new user $input_user\n"
useradd -m --groups root,wheel,docker $input_user

echo -e "$input_user ALL=(ALL) NOPASSWD:ALL\n" > /etc/sudoers.d/$input_user

archey3

echo -e "\n\tadd basic user utilities to root user\n"
echo "ROOT" | xargs ./user_install.sh

cp Xstuff/root_bashrc $HOME/.bashrc
sed -i 's/color = blue/color = red/' $HOME/.archey3.cfg
cp Xstuff/10-monitor.conf   /etc/X11/xorg.conf.d/
# cp Xstuff/20-synaptics.conf /etc/X11/xorg.conf.d/

if [[ $2 -eq "vbox" ]] ; then
    echo -e "\n\tadopting the default netctl profile for wired connection..\n"
    cd /etc/netctl/
    cp examples/ethernet-dhcp .
    sed -i 's/Interface=eth0/Interface=enp0s3/' ethernet-dhcp
    netctl enable ethernet-dhcp
else
    echo -e "\n\tremember to copy a valid netctl profile for wireless connection and enable it.."
fi
echo -e "\n\tremember to set the new user [$input_user] and root password!\n\tjust exec the following command:\n\tpasswd [username]\n\n\tthen continue with:\n\n\t\tsu $input_user\n\t\t./user_install.sh\n"