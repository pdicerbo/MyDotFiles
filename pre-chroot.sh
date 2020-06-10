#!/bin/bash

pacstrap_cmd="pacstrap /mnt base base-devel linux linux-firmware"
echo -e "\n\texecuting $pacstrap_cmd...\n"
eval $pacstrap_cmd

echo -e "\n\tgenerating fstab...\n"
genfstab -U /mnt >> /mnt/etc/fstab

echo -e "\n\tnow continue by executing arch-chroot /mnt /bin/bash and ./install_base_pkgs.sh user [vbox|std_install]\n"