#!/bin/bash

echo -ne "
-------------------------------------------------------------------------
                          Configuring System
-------------------------------------------------------------------------
"

# Set time zone (replace with your time zone)
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime  # Example for Kolkata
hwclock --systohc

# Locale configuration (replace with your language and encoding)
locale-gen en_US.UTF-8
echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo KEYMAP=us >> /etc/vconsole.conf
# Set hostname (replace with your desired hostname)
echo arch >> /etc/hostname

# Install bootloader (adjust for your boot mode - UEFI or BIOS)
grub-install /dev/sda
sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/"$/ pci=realloc"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Configuring Pacman
sed -i '/^#ParallelDownloads/s/^#//' /etc/pacman.conf
sed -i '/^#Color/s/^#//' /etc/pacman.conf
sed -i '/ParallelDownloads/a ILoveCandy' /etc/pacman.conf

# Set root password
passwd

# Create a user (replace with your desired username)
useradd -m -G wheel -s /bin/fish badboy
passwd badboy

# Enable wheel group for sudo access
sed -i '/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^#//' /etc/sudoers

# Enable NetworkManager
systemctl enable NetworkManager
