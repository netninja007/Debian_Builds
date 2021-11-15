#!/usr/bin/env bash

#Update system
apt update

#Upgrade system
apt upgrade

#Install ssh
apt install ssh

#Remove default ssh config file and replace with hardened config file
rm /etc/ssh/sshd_config && cp sshd_config /etc/ssh/

#Start ssh server
systemctl start ssh

#Enable ssh server on start-up
systemctl enable ssh

#Switch to home directory
cd ~

#Generate SSH keys
ssh-keygen

#Get users public key
echo "Paste your public key now". (If none, just press ENTER)

#Store users public key in variable "publickey"
read publickey

#Paste public key into "authorized_keys
echo publickey > .ssh/authorized_keys

echo "If you provided a public key restart the SSH server with "sudo systemctl restart ssh". If not, add your public key to the .ssh/authorized_keys file and then restart the ssh server to apply the changes"
