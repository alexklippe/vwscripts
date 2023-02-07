# vwscripts
vaultwarden install and upfate in debian 11


Installation
Install.sh will install the newest version of vaultwarden.
```
# If logged in as root add a user using these commands prior to install: 
$ adduser vaultwarden
$ usermod -a -G sudo vaultwarden
# Switch to vaultwarden user (script won't run as root) 
$ su vaultwarden
# Change Directory to vaultwarden home 
$ cd ~/
# Download the install script from github 
$ wget https://raw.githubusercontent.com/alexklippe/vwscripts/main/vaultwarden_install_v1.sh
# Set Script as executable 
$ chmod +x vaultwarden_install_v1.sh
# Run script 
$ ./vaultwarden_install_v1.sh
```
Fill in info as requested as the script runs.

Once complete go to https://yourdomain/admin

Update
```
# Download the update script from github 
$ wget https://raw.githubusercontent.com/alexklippe/vwscripts/main/vaultwarden_update_v1.sh
# Set Script as executable 
$ chmod +x vaultwarden_update_v1.sh
# Run script $ ./vaultwarden_update_v1.sh
```
Fill in info as requested as the script runs.
