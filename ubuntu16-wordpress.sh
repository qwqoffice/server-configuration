#!/bin/bash
apt-get update
apt-get -y dist-upgrade && apt-get -y autoremove
apt-get install -y apache2
apt-get install -y php7.0 libapache2-mod-php7.0
apt-get install unzip
apt-cache search php7.0
apt-get install -y php7.0-gd 
apt-get install -y php7.0-mysql php7.0-curl php7.0-intl php-pear php7.0-imap php7.0-zip php7.0-mcrypt php7.0-pspell php7.0-recode  php7.0-sqlite3 php7.0-tidy  php7.0-xsl   php-imagick
apt-get install -y mysql-server mysql-client   
apt-get -y install phpmyadmin   
cd /var/www/html/
rm index.html
ln -s /usr/share/phpmyadmin phpmyadmin
wget http://wordpress.org/latest.zip
unzip -q latest.zip -d /var/www/html/
rm -rf latest.zip
rsync -avP /var/www/html/wordpress/ /var/www/html/
rm -rf wordpress
cp wp-config-sample.php wp-config.php
vim wp-config.php
vim /etc/apache2/sites-available/000-default.conf
#   ServerName 52.8.123.226
#   <Directory /var/www/html/>
#       AllowOverride All
#   </Directory>
a2enmod rewrite
a2enmod expires
a2enmod headers

cat >> /var/www/html/.htaccess <<end
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# protect xmlrpc
<Files xmlrpc.php>
Order Deny,Allow
Deny from all
</Files>
end

vim /etc/php/7.0/apache2/php.ini
#post_max_size = 128M
#upload_max_filesize = 128M
 
chmod -R 755 /var/www/html
chown -R www-data.www-data /var/www/html
service apache2 restart
mysql -u root -p123456
#CREATE DATABASE wordpressdb;
#CREATE USER qwqoffice@localhost IDENTIFIED BY '123456';
#GRANT ALL PRIVILEGES ON wordpressdb.* TO qwqoffice@localhost;
#FLUSH PRIVILEGES;
exit;
