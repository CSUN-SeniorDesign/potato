***Copy over the files to the remote machine that need writing to and just move the file to the correct location***
### Script to install set up ssh connection (ON Remote Machine)
```
#!/bin/bash
gsettings set org.gnome.desktop.session idle-delay 0 && \
gsettings set org.gnome.desktop.screensaver lock-enabled false
sudo apt update -y && \
sudo apt install -y net-tools curl ssh ufw python
ifconfig | grep "inet"
sudo ufw enable && \
sudo ufw default deny incoming && \
sudo ufw default allow outgoing && \
sudo ufw allow http && \
sudo ufw allow https && \
sudo ufw allow ssh
```

### Script to install ansible (ON Master Machine)
```
#!/bin/bash
gsettings set org.gnome.desktop.session idle-delay 0 && \
gsettings set org.gnome.desktop.screensaver lock-enabled false
sudo apt update -y && \
sudo apt install -y software-properties-common && \
sudo apt-add-repository -y ppa:ansible/ansible && \
sudo apt update -y && \
sudo apt install -y python ansible
ssh-keygen -t rsa -N "" -f id_rsa
ssh-copy-id -i ~/.ssh/id_rsa software-irrigation@192.168.64.128
echo "[webservers] \r host1 ansible_ssh_host=192.168.64.128" > /etc/ansible/hosts
sudo mkdir /etc/ansible/group_vars && \
echo "--- \r ansible_ssh_user: root" >> /etc/ansible/group_vars/servers
ansible -m ping webservers
```

### Script to download and install LAMP Stack and Laravel (ON Remote Machine)
```
#!/bin/bash
sudo apt-get -y update && \
sudo add-apt-repository -y ppa:ondrej/php && \
sudo apt-get update && \
sudo apt-get -y install net-tools curl apache2 mysql-server libapache2-mod-php7.2 php7.2 php7.2-xml php7.2-gd php7.2-opcache php7.2-mbstring phpmyadmin php-mbstring php-gettext php-mysql
sudo ufw allow in "Apache Full"
sudo mysql && \
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; && \
FLUSH PRIVILEGES; && \
exit
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF
cd /tmp && curl -sS https://getcomposer.org/installer | php && \
sudo mv composer.phar /usr/local/bin/composer
cd /var/www/html && \
sudo composer create-project laravel/laravel software-irrigation --prefer-dist
sudo chgrp -R www-data /var/www/html/your-project
sudo chmod -R 775 /var/www/html/your-project/storage
sudo a2dissite 000-default.conf && \
sudo a2ensite laravel.conf && \
sudo a2enmod rewrite && \
sudo service apache2 restart
```
