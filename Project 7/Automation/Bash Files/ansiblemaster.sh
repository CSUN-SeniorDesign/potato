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
yes | ssh-copy-id software-irrigation@192.168.64.134
# ---------------------------------------
# Send ssh key to remote machine(s) finished.
# ---------------------------------------
# ---------------------------------------
# Configuring ansible starting.
# ---------------------------------------
sudo mkdir /etc/ansible/group_vars
yes | sudo cp hosts /etc/ansible/
yes | sudo cp webservers /etc/ansible/group_vars/
# ---------------------------------------
# Configuring ansible finished.
# ---------------------------------------
ansible -m ping webservers
