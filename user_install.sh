#!/bin/bash

echo -e "\n\tfinalizing new user environment\n"

set -ex

cd $HOME
git clone https://github.com/pdicerbo/MyDotFiles.git

echo -e "\n\tbase utils files adopted\n"
cd MyDotFiles
cp gitconfig $HOME/.gitconfig

mkdir -p $HOME/.scripts
cp scripts/* $HOME/.scripts/

export PATH=$PATH:$HOME/.scripts

if [[ $# -eq 1 ]] ; then
    rm -f $HOME/.scripts/change_username
fi

cd Xstuff
cp bashrc $HOME/.bashrc
cp bash_profile $HOME/.bash_profile
cp xinitrc $HOME/.xinitrc
cp Xresources $HOME/.Xresources

echo -e "\n\tadopting awesome and conky cfg files..\n"
mkdir -p $HOME/.config/
cp -r awesome $HOME/.config/
cp picom.conf $HOME/.config/
cp -r conky $HOME/.config/conky_cfg
cp -r archey4 $HOME/.config/

if [[ $# -eq 1 ]] ; then
    cd $HOME
    rm -rf MyDotFiles
    exit 0  # the final user is expected to install the other packages
fi

echo -e "\n\tinstalling Visual Studio Code...\n"
vscode_upgrade

echo -e "\n\tinstalling Google Chrome...\n"
gchrome_upgrade

echo -e "\n\tinstalling Archey...\n"
archey4_upgrade

echo -e "\n\tinstalling some urxvt extensions..."

cd $HOME
mkdir -p $HOME/.urxvt/ext/
git clone https://github.com/simmel/urxvt-resize-font.git

mv urxvt-resize-font/resize-font $HOME/.urxvt/ext/

LINK_FOLDER_ROOT=$HOME
echo -e "\n\tcreating link to shared folder into $LINK_FOLDER_ROOT\n"
mkdir -p $LINK_FOLDER_ROOT
ln -s /media/sf_shared $LINK_FOLDER_ROOT/shared

echo -e "\n\tcleaning directories and exit\n"
cd $HOME
rm -rf MyDotFiles urxvt-resize-font
echo -e "\n\tremember to remove the original repo folder!\n"

