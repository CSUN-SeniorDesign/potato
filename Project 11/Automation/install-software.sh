#!/usr/bin/env bash
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install apache2 mysql-server php libapache2-mod-php php-mysql -y && \
sudo apt-get install phpmyadmin php-mbstring php-gettext -y && \
sudo apt-get install npm composer -y && \
sudo npm install -g @angular/cli
