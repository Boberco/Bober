#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install libxcb-xinerama0 -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=a91531344d63c377173272416dfe32f42ad12949617c825832&filename=bober-qt-linux.tar.gz" -O bober-qt-linux.tar.gz

mkdir $HOME/Desktop/Bober

tar -xzvf bober-qt-linux.tar.gz --directory $HOME/Desktop/Bober

mkdir $HOME/.bober

cat << EOF > $HOME/.bober/bober.conf
rpcuser=rpc_bober
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/Bober/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./bober-qt
EOF

chmod +x $HOME/Desktop/Bober/start_wallet.sh

cat << EOF > $HOME/Desktop/Bober/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./bober-cli generatetoaddress 1 \$(./bober-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/Bober/mine.sh
    
exec $HOME/Desktop/Bober/bober-qt &

sleep 15

exec $HOME/Desktop/Bober/bober-cli -named createwallet wallet_name="" &
    
sleep 15

cd $HOME/Desktop/Bober/

clear

exec $HOME/Desktop/Bober/mine.sh
