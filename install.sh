#!/bin/bash

#Update and upgrade the system to the latest version.
apt update && apt upgrade

#Install the command wget (used to fetch the nextcloud install zip file).
apt install wget

#Install the command unzip (used to unzip the nextcloud install file).
apt install unzip

#Install the the software nginx (the web server software used to serve nextcloud).
apt install nginx

#Install the database mariadb (the database which nextcloud will connect to).
apt install mariadb-server

#Install certbot (used to request an SSL certificate (HTTPS) for your domain).
apt install certbot python3-certbot-nginx

#Start the nginx service.
systemctl start nginx

#Enable the nginx service on start-up.
systemctl enable nginx

#Start the mariadb database.
systemctl start mariadb

#Enable the mariadb database on start-up.
systemctl enable mariadb

#Install the required php programs nextcloud needs to function.
apt install php7.4 php7.4-fpm php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl php-imagick php7.4-zip php7.4-xml php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp

#Start the php fpm service.
systemctl start php7.4-fpm

#Enable the php fpm service.
systemctl enable php7.4-fpm

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

#Restart the nginx service to apply the changes.
systemctl restart nginx

#Fetch the latest nextcloud release (this URL needs to be changed/updated accourding to the latest release.
wget https://download.nextcloud.com/server/releases/nextcloud-22.2.0.zip

#Unzip the nextcloud folder contents into the directory "/usr/share/nginx". This is where the nextcloud files will be stored.
unzip nextcloud-22.2.0.zip -d /usr/share/nginx

#Change the user and group ownership permissions of the directory "/usr/share/nginx/nextcloud" to user/group "www-data".
chown -R www-data:www-data /usr/share/nginx/nextcloud

#Remove the default website configuration that's applied when nginx installs. This configuration takes precendence over our nextcloud configuration so we remove it.
rm /etc/nginx/sites-enabled/default

#Print the folling string to get input regarding which email to use for SSL certificate info.
echo What email should I use to register your SSL certifcate?

#Store user's input in the variable "email".
read email

#Use the certbot program to request an SSL certificate using both "email" and "domain" variables.
sudo certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email $email -d $domain
