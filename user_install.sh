#!/bin/bash

echo -e "\n\tfinalizing new user environment\n"

set -ex

cd $HOME
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles-bare-repo --work-tree=$HOME"
git clone --branch topic/hyprland --bare https://github.com/pdicerbo/dotfiles.git $HOME/.dotfiles-bare-repo
dotfiles checkout

if [[ $# -eq 1 ]] ; then
    cd $HOME
    rm -rf MyDotFiles
    exit 0  # the final user is expected to install the other packages
fi

echo -e "\n\tinstalling Google Chrome...\n"
gchrome_upgrade

LINK_FOLDER_ROOT=$HOME
echo -e "\n\tcreating link to shared folder into $LINK_FOLDER_ROOT\n"
mkdir -p $LINK_FOLDER_ROOT
ln -s /media/sf_shared $LINK_FOLDER_ROOT/shared

echo -e "\n\tcleaning directories and exit\n"
cd $HOME
rm -rf MyDotFiles
echo -e "\n\tremember to remove the original repo folder!\n"
