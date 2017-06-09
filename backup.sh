#/bin/bash
mkdir -p /mysqlbackup/backup/
apt-get install zip 
cat > /mysqlbackup/mysqlbackup.sh <<end
#/bin/bash
rq=`date +%Y%m%d`
mysqldump -uroot -p123456 wordpressdb > /mysqlbackup/backup/mysql$rq.sql

find /mysqlbackup/backup/ -name "*" -type f -mtime +3 -exec rm {} \;
zip -q -r /mysqlbackup/backup/$rq.zip  /var/www/html/
end
chmod 777 /mysqlbackup/mysqlbackup.sh
cd /mysqlbackup
cat >>/etc/crontab <<end

30 3 * * * root /mysqlbackup/mysqlbackup.sh
end
/etc/init.d/cron restart
