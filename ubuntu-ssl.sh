a2enmod ssl
a2ensite default-ssl.conf

vim /etc/apache2/sites-enabled/default-ssl.conf

ServerName www.example.com
<Directory /var/www/html/>
    AllowOverride All
</Directory>

SSLCertificateChainFile   /etc/ssl/1_root_bundle.crt
SSLCertificateFile        /etc/ssl/certs/2_www.example.com.crt 
SSLCertificateKeyFile     /etc/ssl/private/3_www.example.com.key

service apache2 restart
