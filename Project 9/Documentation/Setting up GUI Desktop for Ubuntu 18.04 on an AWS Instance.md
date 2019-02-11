## Creating an AWS Instance
1. Login to the Console https://potatocompany.signin.aws.amazon.com/console
2. Go to EC2 then click the Launch Instance button.
3. Select Ubuntu Server 18.04 LTS 64-bit (x86)
4. Select t2.micro or m3.medium.
5. Select Review and Launch but click on Edit Security Groups.
6. Select an existing security group then set up these rules:

  ```
    SSH TCP 22 0.0.0.0/0
    SSH TCP 22 ::/0
    RDP TCP 3389 0.0.0.0/0
  ```
7. Select the Launch button.
8. Create a new key pair and name the key pair ```irrigation```.
9. Download the key pair and click Launch Instances.

## Logging onto the instance using Putty
1. Open Putty and PuttyGen.
2. In PuttyGen, click Load and select the irrigation.pem file that was downloading from the previous tutorial.
3. Once loaded, select Save private key.
4. Close PuttyGen.
5. Get the IPv4 public IP address from the EC2 Management Console.
6. Paste that IP into the Host Name textbox then give the name ```EC2 Instance Irrigation``` to the Saved Sessions textbox.
7. Go to SSH > Auth > Private key file for authentication and select irrigation.ppk
8. When prompted ```Login as:``` use the username ```ubuntu```

## Logging onto the instance using Linux shell

## Setting up GUI Desktop for Ubuntu 18.04 on AWS Instance
1. Update and upgrade.
  ```
  sudo apt update -y && sudo apt upgrade -y
  ```

2. Enable password authentication and restart SSH.
  ```
  sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
  sudo /etc/init.d/ssh restart
  ```

3. Give a password to the ubuntu account.
  ```
  sudo passwd ubuntu
  ```

4. Install certain programs.
  ```
  sudo apt install xrdp xfce4 xfce4-goodies tightvncserver firefox -y
  ```

5. Update settings and restart the xrdp service
  ```
  echo xfce4-session > /home/ubuntu/.xsession && \
  sudo cp /home/ubuntu/.xsession /etc/skel && \
  sudo sed -i '0,/-1/s//ask-1/' /etc/xrdp/xrdp.ini && \
  sudo service xrdp restart
  ```

## Logging into the Desktop GUI using Remote Desktop Connection
1. Open Remote Desktop Connection on a Windows computer.
2. Copy the public IP of the AWS instance.
3. Paste it into the computer textbox and attach ```:3389``` afterwards.
4. Click on the show options button.
5. In the Display tab, select High Color 16 bit.
6. In the Experience tab, select LAN and uncheck all the checkboxes.
7. Select connect.
8. When prompted for a login, select Xvnc as the session and ubuntu as the username. Input the password that was created in the ```Setting up GUI Desktop for Ubuntu 18.04 on AWS Instance``` tutorial.
