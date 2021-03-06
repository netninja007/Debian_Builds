#!/usr/bin/env bash

#Update and upgrade the system to the latest version.
apt update && apt upgrade

#Install dependencies
apt install wget unzip nginx mariadb-server certbot python3-certbot-nginx php7.4 php7.4-fpm php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl php-imagick php7.4-zip php7.4-xml php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp

#Enable nginx on start-up and start the service
systemctl enable nginx && systemctl start nginx

#Enable mariadb on start-up and start the service
systemctl enable mariadb && systemctl start mariadb

#Enable php-fpm on start-up and start the service
systemctl enable php7.4-fpm && systemctl start php7.4-fpm

#"mysql_secure_installation" is a script for securely setting up the database.
mysql_secure_installation

#Enter the mariadb program. Here you need to create the database, grant the necessary privileges and apply them. See "README.md" regarding the commands needed here.
mariadb

#Print to the terminal the following line.
echo "What is your domain name?"

#Capture user's input and store it in the variable "domain".
read domain

#In the "nextcloud.conf" file, replace "user_domain" with the user's supplied input which is stored in the variable domain.
sed -i -e "s/user_domain/$domain/g" nextcloud.conf

#Copy the "nextcloud.conf" to the nginx configuration directory.
cp nextcloud.conf /etc/nginx/conf.d/nextcloud.conf

#Remove the default website configuration that's applied when nginx installs. This configuration takes precendence over our nextcloud configuration so we remove it.
rm /etc/nginx/sites-enabled/default

#Restart the nginx service to apply the changes.
systemctl reload nginx

#Fetch the latest nextcloud release (this URL needs to be changed/updated accourding to the latest release.
wget https://download.nextcloud.com/server/releases/nextcloud-22.2.0.zip

#Unzip the nextcloud folder contents into the directory "/usr/share/nginx". This is where the nextcloud files will be stored.
unzip nextcloud-22.2.0.zip -d /usr/share/nginx

#Change the user and group ownership permissions of the directory "/usr/share/nginx/nextcloud" to user/group "www-data".
chown -R www-data:www-data /usr/share/nginx/nextcloud

#Print the folling string to get input regarding which email to use for SSL certificate info.
echo What email should I use to register your SSL certifcate?

#Store user's input in the variable "email".
read email

#Use the certbot program to request an SSL certificate using both "email" and "domain" variables.
sudo certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email $email -d $domain
