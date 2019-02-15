## Setting up YouTrack with JAR
**This method requires at least 4GB of memory.**
https://www.jetbrains.com/help/youtrack/standalone/youtrack-jar.html

1. Install Java
  ```
  sudo apt install default-jre
  ```

2. Run this command:
  ```
  sudo adduser youtrack --disabled-password
  ```

3. Run this command:
  ```
  sudo wget -O /home/youtrack/youtrack.jar https://download.jetbrains.com/charisma/youtrack-2018.4.49352.jar
  ```

4. Run this command:
  ```
  sudo chown youtrack:youtrack /home/youtrack/youtrack.jar
  ```

5. Create this file:
  ```
  sudo nano /etc/systemd/system/youtrack.service
  ```

  Then paste this into the file:
  ```
  [Unit]
  Description=Youtrack
  Requires=network.target
  After=syslog.target network.target

  [Service]
  Type=simple
  WorkingDirectory=/home/youtrack
  ExecStart=/usr/bin/java -jar /home/youtrack/youtrack.jar --J-Xmx1G 8080
  User=youtrack

  [Install]
  WantedBy=default.target
  ```

  **UPDATED ON 2/15/18**

  **THE ABOVE ABOUT THE EXECSTART LINE HAS TO BE CHANGED ONCE TLS IS SETUP. DO THIS INSTEAD:**

  ```
  change :
  ExecStart=/usr/bin/java -jar /home/youtrack/youtrack.jar --J-Xmx1G 8080

  to:
  ExecStart=/usr/bin/java -jar /home/youtrack/youtrack.jar --J-Xmx1G 8443
  ```

6. Run these commands:
  ```
  sudo systemctl daemon-reload && \
  sudo systemctl enable youtrack.service && \
  sudo service youtrack start
  ```

7. Get the token for initial setup by running these commands:
  ```
  cat /home/youtrack/teamsysdata/conf/internal/services/configurationWizard/wizard_token.txt
  ```

8. Go to http://18.216.39.234:8080/login and enter the token from the previous step.

9. admin , grouppotato, YouTrack Default 42bd2ce4dbaf8554bf082946a1c039d4384e81a99ed53fb75215c1b6ace8d34cf66889fdeee418cbe93d54f38f6e94a8a05a0108234b1955582d566283e3d084b23a0b8b52b016b0e610abcbbe7573fa3ff8fb3cdc9346dc94ef5f596f5b12719abcb02e6fae23d98f53f22a01788066aac7298b7fe79cc3dcd6f8df2fb41ab4
