#!/bin/bash

apt update && apt upgrade

apt install wget

apt install unzip

apt install nginx

apt install mariadb-server

apt install certbot python3-certbot-nginx

systemctl start nginx

systemctl enable nginx

systemctl start mariadb

systemctl enable mariadb

apt install php7.4 php7.4-fpm php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl php-imagick php7.4-zip php7.4-xml php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp

systemctl start php7.4-fpm

systemctl enable php7.4-fpm

mysql_secure_installation

mariadb

echo What is your domain name?

read onion

sed -i -e "s/onion-domain/$onion/g" nextcloud.conf

cp nextcloud.conf /etc/nginx/conf.d/nextcloud.conf

systemctl restart nginx

wget https://download.nextcloud.com/server/releases/nextcloud-22.2.0.zip

unzip nextcloud-22.2.0.zip -d /usr/share/nginx

chown -R www-data:www-data /usr/share/nginx/nextcloud

rm /etc/nginx/sites-enabled/default

echo What email should I use to register your SSL certifcate?

read email

sudo certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email $email -d $onion
