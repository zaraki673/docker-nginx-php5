#!/bin/bash
# Starts up Nginx and PHP within the container.

DATADIR="/data"

# Don't continue if we catch an error.
set -e

service php5-fpm start
/usr/sbin/nginx
