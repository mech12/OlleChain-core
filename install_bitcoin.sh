#!/bin/sh

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install build-essential libtool autotools-dev autoconf pkg-config libssl-dev -y
sudo apt-get install libboost-all-dev -y
sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler -y
sudo apt-get install libqrencode-dev autoconf openssl libssl-dev libevent-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo apt-get install libzmq3-dev -y
#https://github.com/bitcoin/bitcoin/issues/7970
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

cd ~
git clone https://github.com/zhq422194011/bitcoin.git
cd ~
mkdir bitcoin/db4/
wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
tar -xzvf db-4.8.30.NC.tar.gz
rm db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix/
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/home/theusername/bitcoin/db4/
make install

cd ~/bitcoin/
./autogen.sh
./configure LDFLAGS="-L/home/theusername/bitcoin/db4/lib/" CPPFLAGS="-I/home/theusername/bitcoin/db4/include/"

make -s -j5

cd ~
mkdir .bitcoin
mkdir .bitcoin2
cp bitcoin/bitcoin.conf .bitcoin/bitcoin.conf
cp bitcoin/bitcoin.conf .bitcoin2/bitcoin.conf
