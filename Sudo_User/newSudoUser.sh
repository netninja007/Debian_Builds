#!/usr/bin/env bash

#Update repository.
apt update

#Upgrade system.
apt upgrade

#Install sudo command.
apt install sudo

#Point the PATH variable to /usr/sbin.
cp .bashrc /root/.bashrc

#Not sure what this line does exactly...
source ~/.bashrc

#Get user input regarding the name of the user.
echo Hello, what user am I speaking with?

#Store username in variable varname.
read varname

#Run the adduser command with the user's supplied input as the argument
adduser $varname

#Grant user sudo privelleges.
usermod -aG sudo $varname 

#Switch to newly created user
su $varname
