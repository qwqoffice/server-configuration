#/bin/bash
apt-get install vsftpd >>/dev/null
chmod -R 777 /var/www/html
cat > /etc/vsftpd.conf  <<end
listen=YES
anonymous_enable=NO

local_enable=YES

local_root=/var/www/html

seccomp_sandbox=NO

write_enable=YES

allow_writeable_chroot=yes

local_umask=022

dirmessage_enable=YES

use_localtime=YES

xferlog_enable=YES

connect_from_port_20=YES

chroot_list_enable=YES

chroot_list_file=/etc/vsftpd.chroot_list
secure_chroot_dir=/var/run/vsftpd/empty

pam_service_name=ftp

rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
end

cat > /etc/vsftpd.chroot_list <<end
qwqoffice
end
useradd -d /var/www/html qwqoffice

service vsftpd restart
