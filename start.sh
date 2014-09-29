#!/bin/bash -e
DATADIR="/data"

[[ -d "/data/" ]] || mkdir /data
[[ -d "/data/config" ]] || mkdir /data/config
[[ -d "/data/web" ]] || mkdir /data/web

service php5-fpm start
chmod 666 /var/run/php5-fpm.sock
/usr/sbin/nginx
