## Setting up Gitlab Environment for Server
1. Go into your Command Line and type these commands:
```
sudo apt-get update
sudo apt-get install ca-certificates curl openssh-server postfix
```
The first command just updates your packages while the second command installs the dependencies that are required for Gitlab.

2.You're going to need to be in the /tmp directory.
```
cd /tmp
```
Then we will be downloading a script that will assist with the installation of Gitlab with this command:
```
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
```
Then we will run the script:
```
sudo bash /tmp/script.deb.sh
```
###### The script lets us use the Gitlab maintained repositories as well as use the same package managment tools as our other system packages.

3. Install of Gitlab
```
sudo apt-get install gitlab-ce
```
###### After installing you might have to adjust your firewall settings to allow SSH traffic and HTTP access. You will need to open up the ports to allow SSH and HTTP.

4. Modifying the Gitlab configuration file as needed. You can link the Gitlab server to a domain name or an IP address.
