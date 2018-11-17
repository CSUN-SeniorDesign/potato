***Copy over the files to the remote machine that need writing to and just move the file to the correct location***
### Script to install set up ssh connection (ON Remote Machine)
```
#!/bin/bash
# ---------------------------------------
# Turn off screensaver/lockscreen.
# ---------------------------------------
gsettings set org.gnome.desktop.session idle-delay 0 && \
gsettings set org.gnome.desktop.screensaver lock-enabled false
# ---------------------------------------
# Turn off screensaver/lockscreen finished.
# ---------------------------------------
# ---------------------------------------
# Installing required software starting.
# ---------------------------------------
sudo apt update -y && \
sudo apt install -y net-tools curl ssh ufw python
# ---------------------------------------
# Installing required software finished.
# ---------------------------------------
# ---------------------------------------
# Setting firewall rules starting.
# ---------------------------------------
sudo ufw enable && \
sudo ufw default deny incoming && \
sudo ufw default allow outgoing && \
sudo ufw allow http && \
sudo ufw allow https && \
sudo ufw allow ssh
# ---------------------------------------
# Setting firewall rules finished.
# ---------------------------------------
# ---------------------------------------
# Getting the IP address of the remote machine starting.
# ---------------------------------------
ifconfig | grep "inet"
# ---------------------------------------
# Getting the IP address of the remote machine finished.
# ---------------------------------------
```

### Script to install ansible (ON Master Machine)
```
#!/bin/bash
# ---------------------------------------
# Turn off screensaver/lockscreen.
# ---------------------------------------
gsettings set org.gnome.desktop.session idle-delay 0 && \
gsettings set org.gnome.desktop.screensaver lock-enabled false
# ---------------------------------------
# Turn off screensaver/lockscreen finished.
# ---------------------------------------
# ---------------------------------------
# Installing required software starting.
# ---------------------------------------
sudo apt update -y && \
sudo apt install -y software-properties-common && \
sudo apt-add-repository -y ppa:ansible/ansible && \
sudo apt update -y && \
sudo apt install -y python ansible
# ---------------------------------------
# Installing required software finished.
# ---------------------------------------
# ---------------------------------------
# Send ssh key to remote machine(s) starting.
# ---------------------------------------
ssh-keygen -t rsa -N "" -f id_rsa
ssh-copy-id -i ~/.ssh/id_rsa software-irrigation@192.168.64.128
# ---------------------------------------
# Send ssh key to remote machine(s) finished.
# ---------------------------------------
# ---------------------------------------
# Configuring ansible starting.
# ---------------------------------------
sudo mkdir /etc/ansible/group_vars
cp hosts /etc/ansible/
cp webservers /etc/ansible/group_vars/
# ---------------------------------------
# Configuring ansible finished.
# ---------------------------------------
ansible -m ping webservers
```

### Script to download and install LAMP Stack and Laravel (ON Remote Machine)
```
#!/bin/bash
# ---------------------------------------
# Installing required software starting.
# ---------------------------------------
sudo apt-get -y update && \
sudo add-apt-repository -y ppa:ondrej/php && \
sudo apt-get update && \
sudo apt-get -y install net-tools curl apache2 mysql-server libapache2-mod-php7.2 php7.2 php7.2-xml php7.2-gd php7.2-opcache php7.2-mbstring phpmyadmin php-mbstring php-gettext php-mysql
# ---------------------------------------
# Installing required software finished.
# ---------------------------------------
# ---------------------------------------
# Configuring mysql server starting.
# ---------------------------------------
sudo mysql -e "UPDATE mysql.user SET authentication_string = PASSWORD('password') WHERE User = 'root'"
sudo mysql -e "DROP USER ''@'localhost'"
sudo mysql -e "DROP USER ''@'$(hostname)'"
sudo mysql -e "DROP DATABASE test"
sudo mysql -e "FLUSH PRIVILEGES"
# ---------------------------------------
# Configuring mysql server finished.
# ---------------------------------------
# ---------------------------------------
# Configuring php priority and phpmyadmin starting.
# ---------------------------------------
cp dir.conf /etc/apache2/mods-enabled/
cp phpmyadmin.conf /etc/apache2/conf-available/phpmyadmin.conf
cp .htacess /usr/share/phpmyadmin/
sudo phpenmod mbstring
sudo systemctl restart apache2
sudo mysql -e "CREATE USER 'software-irrigation'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'software-irrigation'@'localhost' WITH GRANT OPTION;"
echo "password" | sudo htpasswd -i -c /etc/phpmyadmin/.htpasswd software-irrigation

# ---------------------------------------
# Configuring php priority and phpmyadmin finished.
# ---------------------------------------
# ---------------------------------------
# Installing and Configuring Laravel starting.
# ---------------------------------------
cd /tmp && curl -sS https://getcomposer.org/installer | php && \
sudo mv composer.phar /usr/local/bin/composer
cd /var/www/html && \
sudo composer create-project laravel/laravel software-irrigation --prefer-dist
sudo chgrp -R www-data /var/www/html/software-irrigation
sudo chmod -R 775 /var/www/html/software-irrigation/storage
# ---------------------------------------
# Installing and Configuring Laravel finished.
# ---------------------------------------
sudo a2dissite 000-default.conf && \
sudo a2ensite laravel.conf && \
sudo a2enmod rewrite && \
sudo service apache2 restart
```
