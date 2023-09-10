#!/bin/bash
apt-get install apache2 mysql-server php php-mysqlnd php-curl -y
chmod +x /var/www
rm -rf /var/www/html/index.html
cat <<EOF > /var/www/html/index.php
<?php phpinfo();
EOF