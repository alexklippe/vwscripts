#Ensure not running as root
if [ $EUID -eq 0 ]; then
  echo -ne "\033[0;31mDo NOT run this script as root. Exiting.\e[0m\n"
  exit 1
fi

#Username
echo -ne "Enter your created username if you havent done this please do it now, use ctrl+c to cancel this script and do it${NC}: "
read username

#Check Sudo works
if [[ "$EUID" != 0 ]]; then
    sudo -k # make sure to ask for password on next sudo
    if sudo true; then
        echo "Password ok"
    else
        echo "Aborting script"
        exit 1
    fi
fi

echo "Running Script"



#Clean up old folders
rm -rf ~/bitwarden_rs ~/web ~/vaultwarden ~/bw_web*.tar.gz


#Upgrade Rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

#Compile vaultwarden
#not merged yet
#git clone https://github.com/dani-garcia/vaultwarden.git
git clone https://github.com/BlackDex/vaultwarden.git
cd vaultwarden/
git checkout
cargo clean && cargo build --features postgresql --release
cd ..

#Download precompiled webvault
VWRELEASE=$(curl -s https://api.github.com/repos/dani-garcia/bw_web_builds/releases/latest \
| grep "tag_name" \
| awk '{print substr($2, 2, length($2)-3) }') \

wget https://github.com/dani-garcia/bw_web_builds/releases/download/$VWRELEASE/bw_web_$VWRELEASE.tar.gz

tar -xzf bw_web_$VWRELEASE.tar.gz

#Apply Updates and restart Bitwarden_RS
sudo systemctl stop vaultwarden.service
sudo cp -r ~/vaultwarden/target/release/vaultwarden /opt/vaultwarden
sudo rm -rf /opt/vaultwarden/web-vault
sudo mv ~/web-vault /opt/vaultwarden/web-vault
sudo chown -R ${username}:${username} /opt/vaultwarden
sudo systemctl start vaultwarden.service

#restart nginx
sudo service nginx restart
