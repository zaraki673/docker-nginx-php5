#!/bin/bash -e
DATADIR="/data"

[[ -d "/data/" ]] || mkdir /data
[[ -d "/data/config" ]] || mkdir /data/config
[[ -e "/data/config/nginx-default.conf" ]] || cp /etc/nginx/sites-available/default /data/config/nginx-default.conf
[[ -d "/data/web" ]] || mkdir /data/web
chown www-data: /data -R

service php5-fpm start
chmod 666 /var/run/php5-fpm.sock
/usr/sbin/nginx
