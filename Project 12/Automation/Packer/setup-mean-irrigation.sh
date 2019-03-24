#!/bin/sh
sudo apt-get update -y > /dev/null 
sudo apt-get upgrade -y > /dev/null 
sudo apt-get install -y curl git > /dev/null 
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs > /dev/null 
git clone https://github.com/CSUN-Irrigation/MEAN-Shahid-Software-Irrigation
cd MEAN-Shahid-Software-Irrigation
sudo npm install
echo 'OKTA_ORG_URL="https://dev-423841.okta.com"' | sudo tee -a /etc/environment
echo 'OKTA_TOKEN=00ZSLP0Jm4ytPKAA-c_ZDN6WDM_dd8evc3ABs04p8S' | sudo tee -a /etc/environment
echo 'OKTA_CLIENT_ID=0oabr9jsqpLUEqRIy356' | sudo tee -a /etc/environment
echo 'OKTA_CLIENT_SECRET=hCqri2hT_GUy1i-kYbueW9gTr8sm1n0w1M-RS49H' | sudo tee -a /etc/environment
echo 'SECRET=aweoihngaw4g2w34908h23wt4gawaweoik' | sudo tee -a /etc/environment
echo 'OKTA_APPBASEURL=https://irrigationproject.xyz' | sudo tee -a /etc/environment
echo 'OKTA_CALLBACK_URI=https://irrigationproject.xyz/dashboard' | sudo tee -a /etc/environment
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt-get install -y iptables-persistent
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000
sudo iptables-save | sudo tee -a /etc/iptables/rules.v4
echo '#!/bin/sh
cd /home/ubuntu/MEAN-Shahid-Software-Irrigation
sudo npm start
sudo iptables-restore < /etc/iptables/rules.v4' | sudo tee /home/ubuntu/mean-start.sh
sudo chmod u+x /home/ubuntu/mean-start.sh
echo "[Unit]
Description=MEAN service

[Service]
ExecStart=/home/ubuntu/mean-start.sh

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/mean.service
sudo systemctl start mean
sudo systemctl enable mean