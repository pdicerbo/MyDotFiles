#!/bin/bash

echo -e "\n\texecuting pacstrap...\n"
pacstrap /mnt base base-devel linux linux-firmware
echo -e "\n\texecuting genfstab...\n"
genfstab -U /mnt >> /mnt/etc/fstab
