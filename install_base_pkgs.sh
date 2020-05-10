#!/bin/bash

echo "base system upgrade"
# upgrade the system
pacman -Suy --noconfirm

echo "install X server packages"
# install X server
pacman -S --noconfirm xorg xorg-server xorg-apps

echo "install xfce-4 DE"
# install xfce-4 DE
pacman -S --noconfirm xfce4 xfce4-goodies

echo "install base user utilities"
# user utils
pacman -S --noconfirm sudo awesome conky picom rxvt-unicode xsel numlockx archey3 wget

echo "install base development utils"
# development utils
pacman -S --noconfirm gcc make cmake linux-headers perl python3 python-pip docker awk vim emacs

echo "enabling/starting docker service"
systemctl enable docker.service
systemctl start  docker.service

echo "add new user"
useradd -m --groups root,wheel,docker pierluigi

echo "pierluigi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pierluigi

cp MyDotFiles/Xstuff/root_bashrc $HOME/.bashrc

echo "finalizing new user environment"
su pierluigi

cd $HOME
git clone https://github.com/pdicerbo/MyDotFiles.git

echo "base utils files adopted"
cd MyDotFiles
cp gitconfig $HOME/.gitconfig

mkdir -p $HOME/.scripts
cp scripts/* $HOME/.scripts/

cd Xstuff
cp bashrc $HOME/.bashrc
cp bash_profile $HOME/.bash_profile
cp xinitrc $HOME/.xinitrc
cp Xresources $HOME/.Xresources

echo "adopting awesome and conky cfg files.."
mkdir -p $HOME/.config/
cp -r awesome $HOME/.config/

cp -r conky $HOME/.config/conky_cfg

echo "cleaning directories and exit"
cd $HOME
rm -rf MyDotFiles

