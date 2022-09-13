README
=========

Here all my config files.
Current setup:

**AwesomeWM + Picom + conky**

INSTALL SCRIPTS USAGE
------

- to ensure the system clock is accurate, exec:
  - *timedatectl set-ntp true*
- if you have an Italian Keyboard, run this command to change keyboard layout
  - *loadkeys it*
- perform these preliminary operations to partition the disk, mount it, install the basic packages and the *arch-chroot* into new system (tipically the operations are the following, adapt opportunely the partitions ids):
  - *fdisk -l*
  - *fdisk /dev/sda*
  - *n .... w*
  - *mkfs.ext4 /dev/sda1*
  - *mkswap /dev/sda2*
  - *swapon /dev/sda2*
  - *mount /dev/sda1 /mnt*
  - *pacstrap /mnt base base-devel linux linux-firmware*
  - *genfstab -U /mnt >> /mnt/etc/fstab*
  - *arch-chroot /mnt /bin/bash*
- at this point, install git, download this repository (maybe into the /srv folder.) and execute the base packages installation script:
  - *pacman -S git*
  - *cd /srv && git clone -b topic/ats_adapt https://github.com/pdicerbo/MyDotFiles.git*
  - *cd MyDotFiles*
  - *./install_base_pkgs.sh [username] vbox*
- the last script will generate a user called *pierluigi* if user_name is not provided; now **set the *root* and *username* password, then execute**:
  - *su username*
  - *./user_install.sh*
- now you are almost done; exit from the chroot environment and umount the system folder:
  - *exit*
  - *umount -R /mnt*