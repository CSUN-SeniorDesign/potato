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
    # Update the repository list, add the required repositories, then update the list again.
      sudo apt update -y && \
      sudo apt install -y software-properties-common && \
      sudo apt-add-repository -y ppa:ansible/ansible && \
      sudo apt update -y && \
      sudo apt install -y dos2unix git curl net-tools python ansible
# ---------------------------------------
# Installing required software finished.
# ---------------------------------------
#
#
# ---------------------------------------
# Send ssh key to remote machine(s) starting.
# ---------------------------------------
      # Create the SSH key non-interactively.
      cd /home/master/Desktop/.ssh && ssh-keygen -t rsa -N "" -f id_rsa
      # Find the IP Addresses of the hosts and add the SSH key to them.
      # yes | ssh-copy-id software-irrigation@192.168.64.134
# ---------------------------------------
# Send ssh key to remote machine(s) finished.
# ---------------------------------------
#
#
# ---------------------------------------
# Configuring ansible starting.
# ---------------------------------------
    # Create the directory for all the hosts then move the hosts file to that directory.
      sudo mkdir /etc/ansible/group_vars
      sudo cp -R hosts /etc/ansible/
      sudo cp -R webservers /etc/ansible/group_vars/
# ---------------------------------------
# Configuring ansible finished.
# ---------------------------------------
      # ansible -m ping webservers
