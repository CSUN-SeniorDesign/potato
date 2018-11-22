#!/bin/bash
# ---------------------------------------
# Installing required software starting.
# ---------------------------------------
# Update the respository list, add the laravel respository, then update the repository list again.
sudo apt-get -y update && \
sudo add-apt-repository -y ppa:ondrej/php && \
sudo apt-get update && \
# Install all required software
sudo apt-get -y install dos2unix git net-tools curl apache2 mysql-server libapache2-mod-php7.2 php7.2 php7.2-xml php7.2-gd php7.2-opcache php7.2-mbstring phpmyadmin php-mbstring php-gettext php-mysql
# ---------------------------------------
# Installing required software finished.
# ---------------------------------------
# ---------------------------------------
# Configuring mysql server starting.
# ---------------------------------------
# This is equivalent to running mysql_secure_installation
sudo mysql -e "UPDATE mysql.user SET authentication_string = PASSWORD('password') WHERE User = 'root'"
sudo mysql -e "DROP USER ''@'ubuntu'"
sudo mysql -e "DROP USER ''@'$(hostname)'"
sudo mysql -e "DROP DATABASE test"
sudo mysql -e "FLUSH PRIVILEGES"
# ---------------------------------------
# Configuring mysql server finished.
# ---------------------------------------
# ---------------------------------------
# Configuring php priority and phpmyadmin starting.
# ---------------------------------------
sudo cp -R dir.conf /etc/apache2/mods-enabled/
sudo cp -R phpmyadmin.conf /etc/apache2/conf-available/
sudo cp -R .htaccess /usr/share/phpmyadmin/
sudo phpenmod mbstring
sudo systemctl restart apache2
sudo mysql -e "CREATE USER 'software-irrigation'@'ubuntu' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'software-irrigation'@'ubuntu' WITH GRANT OPTION;"
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
cd /home/software-irrigation/Desktop && git clone https://github.com/CSUN-Irrigation/software-irrigation
sudo cp -R /home/software-irrigation/Desktop/software-irrigation /var/www/html/software-irrigation
sudo cp -R laravel.conf /etc/apache2/sites-available/
sudo cp -R .env /var/www/html/software-irrigation/
sudo chgrp -R www-data /var/www/html/software-irrigation
sudo chmod -R 775 /var/www/html/software-irrigation/storage
cd /var/www/html/software-irrigation && php artisan migrate
# ---------------------------------------
# Installing and Configuring Laravel finished.
# ---------------------------------------
# ---------------------------------------
# Manage apache2 configuration starting.
# ---------------------------------------
sudo a2dissite 000-default.conf && \
sudo a2ensite laravel.conf && \
sudo a2enmod rewrite && \
sudo service apache2 restart
# ---------------------------------------
# Manage apache2 configuration finished.
# ---------------------------------------
