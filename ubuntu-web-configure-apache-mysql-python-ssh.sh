#!/bin/bash

# ###########################################################
# Setup UFW Firewall
# ###########################################################
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 3273
sudo ufw enable

# ###########################################################
# Configuring MySQL Database
# ###########################################################

sudo mysql_install_db

VAR=$(expect -c '
spawn apt-get -y install mysql-server
expect "New password for the MySQL \"root\" user:"
send "PasswordHere\r"
expect "Repeat password for the MySQL \"root\" user:"
send "PasswordHere\r"
expect eof
')

echo "$VAR"

sudo /usr/bin/mysql_secure_installation


# ###########################################################
# Service Restart
# ###########################################################
sudo service ssh restart
sudo service apache2 restart

