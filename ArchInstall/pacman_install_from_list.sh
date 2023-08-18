# Reinstall packages from list
# Source: https://wiki.archlinux.org/title/pacman/Tips_and_tricks

pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist))
