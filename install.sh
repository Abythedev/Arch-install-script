#!/bin/bash

# Network configuration (replace with your network device name)
ip link set enp1s0 up

# Synchronize package databases
pacman -Sy

# Mirror Syncing
echo -ne "
-------------------------------------------------------------------------
                           Syncing Mirrors
-------------------------------------------------------------------------
"
reflector --latest 20 --fastest 20 --country 'United States,India' --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Set keyboard layout (replace with your preferred layout)
loadkeys us

# Synchronize package databases again
pacman -Sy --noconfirm archlinux-keyring

# Format partitions
echo -ne "
-------------------------------------------------------------------------
                          Creating Filsystems
-------------------------------------------------------------------------
"
mkfs.btrfs -f /dev/sda1
mkswap /dev/sda2
mkfs.vfat -F 32 /dev/sda3

# Mount partitions
mount /dev/sda1 /mnt
btrfs su cr /mnt/@
umount /mnt
mount -o noatime,compress=zstd,subvol=@ /dev/sda1 /mnt
swapon /dev/sda2
mount --mkdir /dev/sda3 /mnt/boot/efi

# Install base system
echo -ne "
-------------------------------------------------------------------------
                           Installing Base
-------------------------------------------------------------------------
"
pacstrap -K /mnt base linux linux-firmware sof-firmware base-devel amd-ucode grub efibootmgr nano sudo otf-comicshanns-nerd ttf-joypixels fish networkmanager

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

git clone https://github.com/the-abinash/Arch-install-script.git /mnt/Arch-installer

# Chroot into the mounted system
arch-chroot /mnt bash Arch-installer/system_config.sh

echo -ne "
-------------------------------------------------------------------------
                              Completed
-------------------------------------------------------------------------
"
