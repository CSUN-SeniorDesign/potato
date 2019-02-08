## Setting up an EC2 Instance for Irrigation

1. Update the respository list, add the laravel respository, then update the repository list again. Finally install all required software.

  ```
  sudo apt-get -y update && \
  sudo add-apt-repository -y ppa:ondrej/php && \
  sudo apt-get update && \
  sudo apt-get -y install dos2unix git net-tools curl apache2 mysql-server libapache2-mod-php7.2 php7.2 php7.2-xml php7.2-gd php7.2-opcache php7.2-mbstring phpmyadmin php-mbstring php-gettext php-mysql
  ```

2. Run the script that secures mysql.

  ```
  sudo mysql_secure_installation
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

5. Use git to clone the software-irrigation repo.

  ```
  cd /home/ubuntu/ && git clone https://github.com/CSUN-Irrigation/software-irrigation
  ```

6. Copy all configuration and project files to their required locaitons.
  ```
  sudo cp -R /home/ubuntu/software-irrigation /var/www/html/software-irrigation
  ```
