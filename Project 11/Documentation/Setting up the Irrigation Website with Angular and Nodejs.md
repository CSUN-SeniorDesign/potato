## AWS Setup of EC2 Instance
1. Services > EC2 > Launch Instance.
2. Ubuntu Server 18.04 LTS AMI
3. T3.Medium instance type.
4. Add tag: key = type, value = webserver
5. Select an existing security group.

## Security Group Inbound Rules
```
  HTTP || Port 80 || 0.0.0.0/0
  HTTPS || Port 443 || 0.0.0.0/0
  SSH || Port 22 || 0.0.0.0/0
  YouTrack HTTP || Port 8080 || 0.0.0.0/0
  YouTrack HTTPS || Port 8443 || 0.0.0.0/0
  RDP || Port 3389 || 0.0.0.0/0
  Angular || Port 4200 || 0.0.0.0/0
```

## Connecting to the EC2 Instance Using PuTTY
1. Hostname = the IPv4 Public IP on the EC2 Dashboard.

2. SSH > Auth > Private key file for authentication = the key used to create the EC2 Instance.

3. Save then connect.

## Pre-configuration
1. Update the sshd_config file to delay ssh timeout.

  ```
    sudo nano /etc/ssh/sshd_config
  ```

2. Set these variables
```
  ClientAliveInterval 120
  ClientAliveCountMax 720
```

Client sends null packet ever 120 seconds.
The SSH connection stays alive for 120 seconds x 720 intervals = 86400 seconds = 24 hours.

## List of required programs
- Apache2
- MySQL
- php
- phpMyAdmin
- NPM
- Composer
- Angular-CLI

## Installing required programs
1. Update the repository listings and upgrade all installed programs.

  ```
  sudo apt-get update -y && sudo apt-get upgrade -y
  ```

2. Install Apache2.
```sudo apt-get install apache2 - y```

3. Install mySQL server.
```sudo apt-get install mysql-server -y```

4. Install php.
```sudo apt-get install php libapache2-mod-php php-mysql -y```

5. Install phpMyAdmin.
```sudo apt-get install phpmyadmin php-mbstring php-gettext -y```

6. Install npm.
```sudo apt-get install npm -y```

7. Install Angular-CLI.
```sudo npm install -g @angular/cli```

8. Install composer.
```sudo apt-get install composer -y```

## Configuring required programs
1. Make apache2 start when the server does.
```sudo systemctl enable apache2```

2. Start apache2 right now.
```sudo systemctl start apache2```

3. Restart SSH.
```sudo systemctl restart ssh```

4. Configure mySQL.
```sudo mysql_secure_installation```

## Using required programs
1. Login to mySQL.
```sudo mysql```

2. Create a new user.
```CREATE USER 'software-irrigation'@'localhost' IDENTIFIED BY 'grouppotato';```

3. Give the user all the privileges that root has.
```GRANT ALL PRIVILEGES ON * . * TO 'software-irrigation'@'localhost';```

4. Update the permissions.
```FLUSH PRIVILEGES;```

5. Login to phpMyAdmin then create a database called "irrigation".

6. Go into the Backend folder and run this command:
```
cp .env.example .env
```

7. Update the .env file by running this command:
```
sudo nano .env
```

  then updating these variables:

  ```
  DB_DATABASE=irrigation
  DB_USERNAME=software-irrigation
  DB_PASSWORD=
  ```

8. Run the following command to setup the directory.
```
composer install
```

9. Run the following commands to set up the database.
```
php artisan key:generate
php artisan migrate
php artisan jwt:secret
```

10. Fix mySQL error.
```
sudo nano /usr/share/phpmyadmin/libraries/sql.lib.php
```

  Go to line 613 replace
  ```
  (count($analyzed_sql_results['select_expr'] == 1)
  ```

  with

  ```
  (count($analyzed_sql_results['select_expr']) == 1
  ```

## Hosting the Angular/NodeJS App
1. Download the project from github.

  ```
  cd ~ && git clone https://github.com/CSUN-Irrigation/software-irrigation
  ```

2. Run npm install in order to download all dependencies.

  ```
  cd ~/software-irrigation/Frontend && sudo npm install
  ```

3. Running the serve command to listen for external calls on localhost and using the "&" to run the command in the background.

  ```
  ng serve --host=0.0.0.0 &
  ```
