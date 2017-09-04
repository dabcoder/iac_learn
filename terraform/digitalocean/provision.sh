#!/bin/bash
echo "Provisioning the webserver..."

echo "Updating and upgrading..."
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe"
sudo apt-get update -y
sudo apt-get upgrade -y
echo "installing nginx"
sudo apt-get install -y nginx
echo "installing ufw"
sudo apt-get install -y ufw
sudo apt-get update -y
echo "configuring ufw"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow 80
sudo ufw --force enable