## Setting up an EC2 Instance for Irrigation

1. Update the respository list, add the laravel respository, then update the repository list again. Finally install all required software.

  ```
  sudo apt-get -y update && \
  sudo add-apt-repository -y ppa:ondrej/php && \
  sudo apt-get update && \
  sudo apt-get -y install dos2unix git net-tools curl apache2 mysql-server libapache2-mod-php7.2 php7.2 php7.2-xml php7.2-gd php7.2-opcache php7.2-mbstring phpmyadmin php-mbstring php-gettext php-mysql
  ```

2. Run the script that secures mysql. Then add the required user and table.

  ```
  sudo mysql_secure_installation

  sudo mysql
  CREATE USER 'software-irrigation'@'localhost' IDENTIFIED BY 'password';
  GRANT ALL PRIVILEGES ON * . * TO 'software-irrigation'@'localhost';
  CREATE DATABASE irrigation;
  ```

3. Install composer.
  ```
  cd /tmp && curl -sS https://getcomposer.org/installer | php && \
  sudo mv composer.phar /usr/local/bin/composer
  ```

4. Move into the html directory and create the laravel project.

  ```
  cd /var/www/html && \
  sudo composer create-project laravel/laravel software-irrigation --prefer-dist
  ```

5. Use git to clone the software-irrigation repo and the potato repo.

  ```
  cd ~ && git clone https://github.com/CSUN-Irrigation/software-irrigation && \
  cd ~ && git clone https://github.com/CSUN-SeniorDesign/potato
  ```

6. Copy all configuration and project files to their required locations.
  ```
  sudo cp -R /home/ubuntu/software-irrigation /var/www/html/
  ```

8. Move into Project 9 Automation folder and move the files to their required locations.

  ```
  cd ~/potato/'Project 9'/Automation
  ```

9. Move the laravel.conf file to the sites-avilable folder.

  ```
  sudo cp -R laravel.conf /etc/apache2/sites-available/
  ```

10. Move the .env file to the laravel project folder.

  ```
  sudo cp -R .env /var/www/html/software-irrigation/
  ```

11. Move the dir.conf file to the mods-enabled folder.

  ```
  sudo cp -R dir.conf /etc/apache2/mods-enabled/
  ```

12. Move the phpmyadmin.conf file to the conf-available folder.

  ```
  sudo cp -R phpmyadmin.conf /etc/apache2/conf-available/
  ```

13. Move the .htaccess file to the phpmyadmin folder.

  ```
  sudo cp -R .htaccess /usr/share/phpmyadmin/
  ```

14. Change the group and access to the apache2 and give the storage folder proper permissions.

  ```
  sudo chgrp -R www-data /var/www/html/software-irrigation
  sudo chmod -R 775 /var/www/html/software-irrigation/
  ```

15. Move into the project folder and run the php command to create the database.
The database is set up based on the information provided in the .env file.

  ```
  cd /var/www/html/software-irrigation && sudo php artisan migrate
  ```

16. Run htpasswd to enable htaccess

  ```
  echo "password" | sudo htpasswd -i -c /etc/phpmyadmin/.htpasswd software-irrigation
  ```

17. Enable phpenmod

  ```
  sudo phpenmod mbstring
  ```

18. Configure apache2

  ```
  sudo a2dissite 000-default.conf && \
  sudo a2ensite laravel.conf && \
  sudo a2enmod rewrite && \
  sudo service apache2 restart
  ```
