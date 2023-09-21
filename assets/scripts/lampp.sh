#!/bin/bash
#ubuntu and debian clean lampp script 

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
root="asus"
mysql_native_password="test"

echo "remove cache";
sudo rm -rf /var/tmp/* /var/log/*php* /var/www /var/cache/apt/archives/*.deb

clear

echo "remove apache2";
sudo service apache2 stop -y
sudo apt-get apache2 remove
sudo apt-get purge apache2* -y
sudo apt-get autoremove -y
sudo rm -rf /usr/sbin/apache2* /usr/lib/apache2* /etc/apache2* /usr/share/apache2* /usr/share/man/man8/apache2* /var/lib/*apache2*

echo "${green}install apache2${reset}"
sudo apt-get install apache2 -y

echo "default config change"
sudo chown -R ${root} /var/www
sudo chmod +x /var/www
sudo rm -rf /var/www/*
echo "<?php phpinfo(); ?>" > /var/www/index.php

sudo sed -i -e 's%/html%%g' /etc/apache2/sites-available/000-default.conf

sudo systemctl restart apache2

clear

echo "${reset}remove php";
sudo apt-get php8.0 remove
sudo apt-get purge php* -y
sudo apt-get autoremove -y
sudo rm -rf /usr/bin/php* /usr/share/php*

echo "${green}install php";

sudo apt install ca-certificates apt-transport-https software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y
sudo apt install php8.0 libapache2-mod-php8.0 -y
sudo systemctl restart apache2

sudo systemctl status apache2 |cat

clear

echo "${reset} mysql remove"
sudo service mysql-server stop -y
sudo apt-get mysql* remove
sudo apt-get purge mysql* -y
sudo apt-get autoremove -y

sudo rm -rf /etc/mysql /opt/lampp/bin/mysql* /var/lib/mysql*

echo "${green} install mysql"

sudo apt-get install mysql-server -y

sudo mysql -u root -e "SELECT user,authentication_string,plugin,host FROM mysql.user;"

sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${mysql_native_password}';"
sudo mysql -u "root" -p"${mysql_native_password}" -e "SELECT user,authentication_string,plugin,host FROM mysql.user;"

clear

echo "${reset} phpmyadmin remove";

sudo apt-get phpmyadmin* remove
sudo apt-get purge phpmyadmin* -y
sudo apt-get autoremove -y
sudo rm -rf /etc/phpmyadmin* /usr/share/*phpmyadmin*

echo "${green} phpmyadmin install";
sudo apt-get install phpmyadmin -y


sudo sed -i -e "s%cookie%config%g" /etc/phpmyadmin/config.inc.php
sudo sed -i -e "s%cookie%config%g" /etc/phpmyadmin/config.inc.php
sudo sed -i -e "s%controluser%user%g" /etc/phpmyadmin/config.inc.php
sudo sed -i -e "s%controlpass%password%g" /etc/phpmyadmin/config.inc.php
sudo sed -i -e "s%\$dbuser%'root'%g" /etc/phpmyadmin/config.inc.php
sudo sed -i -e "s%\$dbpass%'test'%g" /etc/phpmyadmin/config.inc.php

echo "\$cfg['SendErrorReports'] = 'never';" | sudo tee -a /etc/phpmyadmin/config.inc.php




echo "${green}Server: http://localhost \n User: root \n Password: ${mysql_native_password}"
