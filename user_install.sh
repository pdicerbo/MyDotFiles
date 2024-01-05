#!/bin/bash

echo -e "\n\tfinalizing new user environment\n"

cd $HOME
git clone https://github.com/pdicerbo/MyDotFiles.git

echo -e "\n\tbase utils files adopted\n"
cd MyDotFiles
cp gitconfig $HOME/.gitconfig

mkdir -p $HOME/.scripts
cp scripts/* $HOME/.scripts/

cd Xstuff
cp bashrc $HOME/.bashrc
cp bash_profile $HOME/.bash_profile
cp xinitrc $HOME/.xinitrc
cp Xresources $HOME/.Xresources

echo -e "\n\tadopting awesome and conky cfg files..\n"
mkdir -p $HOME/.config/
cp -r awesome $HOME/.config/
cp picom.conf $HOME/.config/

echo -e "\n\tinstalling Visual Studio Code...\n"
vscode_upgrade

echo -e "\n\tinstalling Google Chrome...\n"
gchrome_upgrade

cp -r conky $HOME/.config/conky_cfg

echo -e "\n\tinstalling some urxvt extensions..."

cd $HOME
mkdir -p $HOME/.urxvt/ext/
git clone https://github.com/simmel/urxvt-resize-font.git

mv urxvt-resize-font/resize-font $HOME/.urxvt/ext/

echo -e "\n\tcleaning directories and exit\n"
cd $HOME
rm -rf MyDotFiles urxvt-resize-font
echo -e "\n\tremember to remove the original repo folder!\n"

