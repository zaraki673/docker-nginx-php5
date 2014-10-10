# Nginx and PHP5
# http://wiki.nginx.org/
# http://us.php.net/

FROM ubuntu:14.04
MAINTAINER Kevin Larsonneur <kl@klarsonneur.eu>
 
# Ensure UTF-8
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62
RUN echo deb http://nginx.org/packages/mainline/ubuntu trusty nginx > /etc/apt/sources.list.d/nginx-stable-trusty.list
RUN apt-get update
RUN apt-get -y upgrade

# Install
RUN apt-get install -y nginx php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-gd libssh2-php php5-memcache php5-memcached php5-curl

RUN mkdir -p /etc/nginx/sites-enabled /etc/nginx/sites-available

RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx-site.conf /etc/nginx/sites-available/default
RUN sed -i -e 's/^listen =.*/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf
RUN echo "include = /data/config/php-*.conf" >> /etc/php5/fpm/pool.d/www.conf

# Create basedirs
RUN mkdir -p /data/web /data/config

# Decouple our data from our container.
VOLUME ["/data"]
VOLUME ["/var/log/nginx"]

EXPOSE 80
ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
