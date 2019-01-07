#!/bin/bash

systemctl enable dhcpcd.service && loadkeys br-abnt2 && pacman -Sy reflector && reflector -l 10 –sort rate –save /etc/pacman.d/mirrorlist && pacstrap /mnt base base-devel && genfstab /mnt >> /mnt/etc/fstab && arch-chroot /mnt && echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen && echo LANG=pt_BR.UTF-8 > /etc/locale.conf && export LANG=pt_BR.UTF-8 && ln -s /usr/share/zoneinfo/Brazil/east /etc/localtime && pacman -S grub && grub-install /dev/sda && mkinitcpio -p linux && grub-mkconfig -o /boot/grub/grub.cfg && pacman -S alsa-utils lxdm xorg xorg-xinit mesa xf86-video-vesa ttf-dejavu lxdm && systemctl enable lxdm.service && useradd -m -g users -G wheel -s /bin/bash wendel && umount -a











