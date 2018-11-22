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
