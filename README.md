README
=========

Here all my config files.
Current setup:

**AwesomeWM + Picom + conky**

INSTALL SCRIPTS USAGE
------

- make a bootable USB with ArchLinux iso image
- establish a network connection by means of netctl utility
  - for a wireless connection, copy an example of cfg file from /etc/netctl/examples/wireless-wpa into /etc/netctl
  - modify the file and exec *netctl start my_profile*
  - test the connection e.g. with *ping www.google.com*
- exec *timedatectl set-ntp true* to ensure the system clock is accurate
- perform these preliminary operations to partition the disk (by means of *fdisk -l*), mount it, install the basic packages and the *arch-chroot* into new system (adapt opportunely the partitions ids):
  - *mkfs.ext4 /dev/sda1*
  - *mkswap /dev/sda2*
  - *swapon /dev/sda2*
  - *mount /dev/sda1 /mnt*
  - *pacstrap -i /mnt base linux linux-firmware*
  - *genfstab -U /mnt >> /mnt/etc/fstab*
  - *arch-chroot /mnt /bin/bash*
- at this point, install git, download this repository (maybe into the /srv folder.) and execute the base packages installation script:
  - *pacman -S git*
  - *cd /srv && git clone https://github.com/pdicerbo/MyDotFiles.git*
  - *cd MyDotFiles*
  - *./install_base_pkgs.sh*
- the last script will generate a user called *pierluigi*; set the *root* and *pierluigi* password, then execute:
  - *su pierluigi*
  - *./user_install.sh*
- now you are almost done; exit from the chroot environment and, if you want, copy the netctl config file:
  - *cp /etc/netctl/my_profile /mnt/etc/netctl/my_profile*
  - adopt the correct interface name (exec *netctl enable my_profile* to attempt the connection at every startup)