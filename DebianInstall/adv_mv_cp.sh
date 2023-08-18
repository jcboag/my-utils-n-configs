# Install mv / cp with progressbar
# Code primarily from: https://github.com/jarun/advcpmv

wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
tar xvJf coreutils-8.32.tar.xz
cd coreutils-8.32/
wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
patch -p1 -i advcpmv-0.8-8.32.patch
./configure
make

# Move binaries to /usr/local/bin
sudo /bin/mv ./src/cp /usr/local/bin/cpg
sudo /bin/mv ./src/mv /usr/local/bin/mvg

cd ..

rm coreutils-8.32.tar.xz
sudo rm -r coreutils-8.32
