#!/bin/bash

#Meu script para a instalação do arch

#habilitar a internet
systemctl enable dhcpcd.service

#carregar padrão de teclado
loadkeys br-abnt2 carregar teclado ptbr

#separar 2g de cowspace
mount -o remount,size=2G /run/archiso/cowspace

#instalar o reflector e escolher os mirroslist
pacman -Sy reflector
reflector -l 10 –sort rate –save /etc/pacman.d/mirrorlist 

#instalar base 
pacstrap /mnt base base-devel

genfstab /mnt >> /mnt/etc/fstab


arch-chroot /mnt
#*********************************
mudar teclado

echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen 

locale-gen

echo LANG=pt_BR.UTF-8 > /etc/locale.conf

export LANG=pt_BR.UTF-8

#para hora
ln -s /usr/share/zoneinfo/Brazil/east /etc/localtime

timedatectl set-ntp true

#hostname
echo wende.arch > /etc/hostname

#Set keyboard for console:

echo KEYMAP=br-abnt2 > /etc/vconsole.conf



#instalar o grub
pacman -S grub

#instalar o grub
grub-install /dev/sda

#gerar as imagens
mkinitcpio -p linux

#boot do sistema
grub-mkconfig -o /boot/grub/grub.cfg 


#----------------------------------------------------------------------

#instalar drive de som
pacman -S alsa-utils pulseaudio

#instalar drive servidor grafico
pacman -S xorg xorg-xinit 

pacman -S mesa 

pacman -S xf86-video-vesa 

#fonte generica 
pacman -S ttf-dejavu

#instalar interface grafica xfce4
#pacman -S xfce4 xfce4-goodies

#instalar interface grafica mate
#pacman -S mate mate-extra

#instalar interface grafica KDE-plasma
#pacman -S plasma-desktop dolphin konsole kate


#instalar o lxdm
pacman -S lxdm

#habilitar 
systemctl enable lxdm.service




#criar usuario
useradd -m -g users -G wheel -s /bin/bash wendel
passwd 123


#mudar senha root 
passwd 123

umount -a

reboot



