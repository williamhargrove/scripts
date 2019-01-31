#!/bin/bash

set -e

majorVersion="0.18.5"
srcPath="./bitcoin-abc-${majorVersion}/bin"
# obtained from bitcoin-cli --version
distribution="v${majorVersion}.0-d1d091ba7"
version="bitcoin-${distribution}"

# download and extract version
wget https://download.bitcoinabc.org/${majorVersion}/linux/bitcoin-abc-${majorVersion}-x86_64-linux-gnu.tar.gz
gunzip bitcoin-abc-${majorVersion}-x86_64-linux-gnu.tar.gz
tar xf bitcoin-abc-${majorVersion}-x86_64-linux-gnu.tar

# stop bitcoin-abc node
sudo systemctl stop bitcoind

sleep 5

# backup wallet file
sudo -u ruby cp -p /home/ruby/.bitcoin/wallet.dat /home/ruby/.bitcoin/wallet.dat.$(date +%F)

sudo mkdir -p /usr/local/bin/${version}
sudo cp ${srcPath}/* /usr/local/bin/${version}
sudo chown -R root.root /usr/local/bin/${version}

cd /usr/local/bin/${version}
for executable in $(ls); do
 sudo rm -f ../${executable}
 sudo ln -s ./${version}/${executable} ../${executable} 
done

# start bitcoin-abc node
sudo systemctl start bitcoind

