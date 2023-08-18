# Reinstall some desired packages and reenable services.
# Keep all files in the same folder.

# Install pacman packages
sudo ./pacman_install_from_list.sh


# Install PIP packages
pip install -r pip-pkglist

# Install yay for AUR packages
./install_yay.sh
yay -S --needed --noconfirm - < ~/AUR-pkglist.txt # https://bbs.archlinux.org/viewtopic.php?id=242307 (MikeW, Post #4)


# Install adv mv and adv cp
./adv_mv_cp.sh
cd ..

# enable services
systemctl enable systemd-networkd
