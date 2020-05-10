#!/bin/bash

echo -e "\n\tfinalizing new user environment"

cd $HOME
git clone https://github.com/pdicerbo/MyDotFiles.git

echo -e "\n\tbase utils files adopted"
cd MyDotFiles
cp gitconfig $HOME/.gitconfig

mkdir -p $HOME/.scripts
cp scripts/* $HOME/.scripts/

cd Xstuff
cp bashrc $HOME/.bashrc
cp bash_profile $HOME/.bash_profile
cp xinitrc $HOME/.xinitrc
cp Xresources $HOME/.Xresources

echo -e "\n\tadopting awesome and conky cfg files.."
mkdir -p $HOME/.config/
cp -r awesome $HOME/.config/

cp -r conky $HOME/.config/conky_cfg

echo -e "\n\tcleaning directories and exit"
cd $HOME
rm -rf MyDotFiles

