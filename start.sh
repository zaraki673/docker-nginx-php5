#!/bin/bash
# Starts up Nginx and PHP within the container.

DATADIR="/data"

# Don't continue if we catch an error.
set -e

# Ensure mysql owns the DATADIR
chown -R www-data $DATADIR

# Change MySQL password to a default
mysqladmin -u root password d3faultPa55word

service mysql start
service php5-fpm start
/usr/sbin/nginx
