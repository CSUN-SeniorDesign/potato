# LAMP Setup with Ubuntu 18.04

### Downloading VMWare Workstation
1. Go to csun-cs.onthehub.com/
2. Look for VMWare Workstation 15
3. Add it to cart.
4. Copy the serial key.
5. Download the program.
6. Install the program with the defaults.

### Downloading and installing Ubuntu 18.04
1. Go to https://www.ubuntu.com/
2. Click on "Download" at the top right of the navigation bar.
3. Choose "Ubuntu 18.04 LTS" under "Ubuntu Desktop" heading.
4. The download will start automatically.
5. Once the download is finished, open up VMWare Workstation.
6. Click "Create a New Virtual Machine"
7. Select "Typical" Installation then click next.
8. Click on the "Installer disc image file (iso)" and point it to the ubuntu iso you just downloaded then click next.
9. Give the installer your name, username, password, confirm the password, and then click next.

    9a. For now I went with
    ```
        Full name: Software Irrigation
        User name: software-irrigation
        Password: 1
    ```
10. Give the virtual machine a name of "Software Irrigation - Ubuntu 18.04 LTS 64-bit" then specify a place to store it and click next.
11. Leave the disc size and split virtual disk into multiple files as default.
12. Click finish.
13. Allow the auto-installer to install Ubuntu 18.04 LTS for you. The VM will restart once the installation is done.
14. Run these commands to turn off the screensaver/lockscreen:
Disable screensaver/lock
```
gsettings set org.gnome.desktop.session idle-delay 0 && \
gsettings set org.gnome.desktop.screensaver lock-enabled false
```

### Installing a LAMP stack
#### Installing Apache
1. Once logged into the machine, open up a terminal.
2. Run ```sudo apt-get update -y``` in order to update the repository listings.
3. Run ```sudo apt-get -y install apache2```
4. Set the firewall to allow incoming connections on ports 80 and 443 by running the command ```sudo ufw allow in "Apache Full"```

    4a. Run ``` sudo apt-get install net-tools ```
    4b. Test that the firewall rule is working after finding out the IP Address of the server by running
    ```
    ip addr show
    ```
    4c. An alternative is to install curl and run this command:
    ```
    sudo apt install curl
    curl http://icanhazip.com
    ```

#### Installing MySQL
1. Run ``` sudo apt install -y mysql-server ```
2. Run ``` sudo mysql_secure_installation ```
3. Press ```y``` for all the questions.
4. Open the MySQL command prompt by running ```sudo mysql```
5. Run ``` ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; ```
6. RUN ``` FLUSH PRIVILEGES; ```
7. Finally, exit the MySQL command prompt ```exit```

### Installing PHP
1. Run ```sudo apt install -y php libapache2-mod-php php-mysql```
2. Modify apache configuration to prefer .php files over .html files ```sudo nano -c  /etc/apache2/mods-enabled/dir.conf```
3. Make the config file look like this:
```
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
```
4. Press ```CTRL + X``` then ```y``` then ```ENTER``` in order to save the changes to the configuration file.
5. Restart the service to implement the changes: ```sudo systemctl restart apache2```
6. Test that the php install is working by running ``` sudo nano -c /var/www/html/info.php ```
7. Inside that file type
```
<?php
phpinfo();
?>
```
8. Visit your website IP address with a /info.php at the end of the IP address.
9. Remove the file after testing. ``` sudo rm /var/www/html/info.php ```

### Installing phpMyAdmin
1. Run ```sudo apt install -y phpmyadmin php-mbstring php-gettext```
2. Press ```SPACE``` then ```TAB``` then ```ENTER``` to select apache2.
3. Give a password for phpMyAdmin.
4. Run ```sudo phpenmod mbstring```
5. Restart the service to implement the changes: ``` sudo systemctl restart apache2```
6. In order to access the mysql command prompt after making root password authenticated run this command: ```mysql -u root -p```
7. Add users with this command: ```CREATE USER 'software-irrigation'@'localhost' IDENTIFIED BY 'password';```
8. Give the new user all privileges by running this command: ```GRANT ALL PRIVILEGES ON *.* TO 'software-irrigation'@'localhost' WITH GRANT OPTION;```
9. Exit and test the new phpMyAdmin install by running ```exit``` and visiting your IP address /phpmyadmin
10. Clean up all installs.
```
sudo apt-get autoremove
```
11. Secure your phpMyAdmin by going into the apache config files ```sudo nano -c  /etc/apache2/conf-available/phpmyadmin.conf```
12. Add ``` AllowOverride All ``` to
```
<Directory /usr/share/phpmyadmin>
    Options FollowSymLinks
    DirectoryIndex index.php
    AllowOverride All
```
13. Save the changes and restart apache to apply those changes: ```sudo systemctl restart apache2```
14. Run ```sudo nano -c  /usr/share/phpmyadmin/.htaccess``` to create a .htaccess for phpmyadmin.
15. Inside that new file write
```
AuthType Basic
AuthName "Restricted Files"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user
```
16. Add a user to the .htaccess ```sudo htpasswd -c /etc/phpmyadmin/.htpasswd software-irrigation```
17. Add more users by running this command ```sudo htpasswd /etc/phpmyadmin/.htpasswd additionaluser```
18. Test that .htaccess is working by visiting the server's IP address /phpmyadmin

### Installing Laravel
1. Add the Laravel repo ```sudo add-apt-repository ppa:ondrej/php```
2. Update the repo list ```sudo apt-get update```
3. Downloading PHP from the repo
```
sudo apt-get install apache2 libapache2-mod-php7.2 php7.2 php7.2-xml php7.2-gd php7.2-opcache php7.2-mbstring
```
4. Installing laravel
```
cd /tmp && \
curl -sS https://getcomposer.org/installer | php && \
sudo mv composer.phar /usr/local/bin/composer
```
5. Create a new project in your apache2 hosting directory. Replace "your-project" with the name of the project you want to create/host.
```
cd /var/www/html
sudo composer create-project laravel/laravel your-project --prefer-dist
```

6. Set the proper permissions on the project:
```
sudo chgrp -R www-data /var/www/html/your-project && \
sudo chmod -R 775 /var/www/html/your-project/storage
```
