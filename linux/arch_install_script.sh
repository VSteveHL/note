#!/bin/sh
# update system clock
timedatectl set-ntp 1

EFIPART=""
ROOTPART=""

if [ -z $EFIPART ] || [ -z $ROOTPART ]
then
    exit
fi

# partition
mkfs.vfat -F32 $EFIPART
mkfs.ext4 -F $ROOTPART
mount $ROOTPART /mnt
mkdir /mnt/boot
mount $EFIPART /mnt/boot

# install packages
pacstrap /mnt base base-devel linux linux-firmware dhcpcd iwd vim man-db man-pages grub efibootmgr openssh intel-ucode git zsh grml-zsh-config tmux wget mesa xorg gnome networkmanager

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# chroot
(
cat <<EOF
echo root:rootpasswd | chpasswd
useradd -m -G wheel vstevehl
echo vstevehl:passwd | chpasswd
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock -w
echo -e "en_US.UTF-8 UTF-8\nzh_CN.UTF-8 UTF-8\nzh_HK.UTF-8 UTF-8\nzh_TW.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
grub-install --efi=/boot
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable sshd
systemctl enable NetworkManager
systemctl enable gdm
timedatectl set-local-rtc 1
exit
EOF
) > /mnt/temp.sh

arch-chroot /mnt /bin/bash -c "bash /temp.sh"
