#!/bin/bash

# Installing timeshift
pacman -Sy timeshift grub-btrfs btrfs-progs

# Timeshift configuration
bash uuid_update.sh
cp timeshift.json /etc/timeshift/

# Creating Snapshot
timeshift --create --comments "Base install"

# Installing reflector
pacman -Sy reflector

# Mirrors syncing
reflector --latest 20 --fastest 20 --country 'United States,India' --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Install additional packages (replace with your desired packages)
pacman -Sy xfce4  xfce4-goodies blueman network-manager-applet file-roller redshift pipewire-pulse pipewire-alsa ntfs-3g lightdm-gtk-greeter lightdm-gtk-greeter-settings gvfs-mtp firefox ffmpegthumbnailer evince speech-dispatcher vlc xdg-user-dirs-gtk starship neofetch

# Redshift configuration
cp redshift.conf /home/badboy/.config/

# Systemctl configuration
systemctl enable --now cronie.service
systemctl enable bluetooth
systemctl enable lightdm

# Shell Configuration
bash shell_config.sh

# Creating Snapshot
timeshift --create --comments "Fresh install"

# Grub Configuration
grub-mkconfig -o /boot/grub/grub.cfg

echo -ne "
-------------------------------------------------------------------------
                              Completed
-------------------------------------------------------------------------
"
