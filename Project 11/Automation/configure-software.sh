#!/usr/bin/env bash
sudo systemctl enable apache2 && \
sudo systemctl start apache2 && \
sudo systemctl restart ssh && \
sudo systemctl restart sshd && \
sudo mysql_secure_installation
