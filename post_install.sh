#!/bin/bash

# Installing reflector
pacman -Sy reflector

# Mirrors syncing
reflector --latest 20 --fastest 20 --country 'United States,India' --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Install additional packages (replace with your desired packages)
pacman -Sy xfce4  xfce4-goodies blueman network-manager-applet file-roller timeshift redshift pipewire-pulse pipewire-alsa ntfs-3g lightdm-gtk-greeter lightdm-gtk-greeter-settings gvfs-mtp firefox ffmpegthumbnailer evince grub-btrfs btrfs-progs speech-dispatcher vlc xdg-user-dirs-gtk starship neofetch

# Redshift configuration
mv redshift.conf /home/badboy/.config/

# Timeshift configuration
bash uuid_update.sh
mv timeshift.json /etc/timeshift/

# Systemctl configuration
systemctl enable --now cronie.service
systemctl enable bluetooth
systemctl enable lightdm

# Shell Configuration
bash shell_config.sh

# Creating Snapshot
timeshift --create --comments "fresh install"

# Grub Configuration
grub-mkconfig -o /boot/grub/grub.cfg

# Reboot the system
reboot
