#!/bin/bash
# ---------------------------------------
# Turn off screensaver/lockscreen.
# ---------------------------------------
    # Turn off the screensaver/lockscreen if there is a desktop environment installed.
      gsettings set org.gnome.desktop.session idle-delay 0 && \
      gsettings set org.gnome.desktop.screensaver lock-enabled false
# ---------------------------------------
# Turn off screensaver/lockscreen finished.
# ---------------------------------------
#
#
# ---------------------------------------
# Installing required software starting.
# ---------------------------------------
    # Update the repository list then install required software.
      sudo apt update -y && \
      sudo apt install -y net-tools curl ssh ufw python
# ---------------------------------------
# Installing required software finished.
# ---------------------------------------
#
#
# ---------------------------------------
# Setting firewall rules starting.
# ---------------------------------------
    # Port 22, 80, and 443 are opened for the future LAMP stack server.
      sudo ufw enable && \
      sudo ufw default deny incoming && \
      sudo ufw default allow outgoing && \
      sudo ufw allow http && \
      sudo ufw allow https && \
      sudo ufw allow ssh
# ---------------------------------------
# Setting firewall rules finished.
# ---------------------------------------
#
#
# ---------------------------------------
# Getting the IP address of the remote machine starting.
# ---------------------------------------
    # Find the IP Address of the remote machine. 
      ifconfig | grep "inet"
# ---------------------------------------
# Getting the IP address of the remote machine finished.
# ---------------------------------------
