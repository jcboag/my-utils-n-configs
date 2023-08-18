# Bluetooth dongle driver
BT_DEB="broadcom-bt-firmware-10.1.0.1115.deb"
cd "$HOME/Downloads"
wget https://github.com/winterheart/broadcom-bt-firmware/releases/download/v12.0.1.1105_p3/$BT_DEB && \
apt install ./$BT_DEB && \
rm ./$BT_DEB
