## Setting up YouTrack with Docker
**This method requires at least 4GB of memory.**

1. Install Docker
2. Run this command:
  ```
  sudo docker pull jetbrains/youtrack:2018.4.49352
  ```
3. Run this command:
  ```
  mkdir -p -m 750 ~/Desktop/YouTrack/data ~/Desktop/YouTrack/logs ~/Desktop/YouTrack/conf ~/Desktop/YouTrack/backups
  ```

4. Run this command:
  ```
  sudo chown -R 13001:13001 ~/Desktop/YouTrack/data ~/Desktop/YouTrack/logs ~/Desktop/YouTrack/conf ~/Desktop/YouTrack/backups
  ```

5. Start the container
  ```
  sudo docker run -dit --name irrigation  \
    -v ~/Desktop/YouTrack/data:/opt/youtrack/data \
    -v ~/Desktop/YouTrack/conf:/opt/youtrack/conf  \
    -v ~/Desktop/YouTrack/logs:/opt/youtrack/logs  \
    -v ~/Desktop/YouTrack/backups:/opt/youtrack/backups  \
    -p 8080:8080 \
    jetbrains/youtrack:2018.4.49352
  ```

6. Go to http://18.216.39.234:8080/login

7. Get the token for initial setup by running these commands:
  ```
  sudo docker ps
  sudo docker exec -it <container name> cat /opt/youtrack/conf/internal/services/configurationWizard/wizard_token.txt
  ```

8. Once you get the token, input it into the login page from step 6.

9. admin , grouppotato, 42bd2ce4dbaf8554bf082946a1c039d4384e81a99ed53fb75215c1b6ace8d34cf66889fdeee418cbe93d54f38f6e94a8a05a0108234b1955582d566283e3d084b23a0b8b52b016b0e610abcbbe7573fa3ff8fb3cdc9346dc94ef5f596f5b12719abcb02e6fae23d98f53f22a01788066aac7298b7fe79cc3dcd6f8df2fb41ab4

10. Run this command:
  ```
  /etc/systemd/system/docker.youtrack.service
  ```

11. Put this in the file:
  ```
  [Unit]
  Description=YouTrack Service
  After=docker.service
  Requires=docker.service

  [Service]
  TimeoutStartSec=0
  Restart=always
  ExecStartPre=-/usr/bin/docker exec %n stop
  ExecStartPre=-/usr/bin/docker rm %n
  ExecStartPre=/usr/bin/docker pull jetbrains/youtrack:<version>
  ExecStart=/usr/bin/docker run --rm --name %n \
      -v <path to data directory>:/opt/youtrack/data \
      -v <path to conf directory>:/opt/youtrack/conf \
      -v <path to logs directory>:/opt/youtrack/logs \
      -v <path to backups directory>:/opt/youtrack/backups \
      -p <port on host>:8080 \
      jetbrains/youtrack:<version>

  [Install]
  WantedBy=default.target
  ```

12. Enable the service on system boot
  ```
  sudo systemctl enable docker.youtrack
  ```

13. Starting and stopping the services
  ```
  sudo service docker.youtrack stop
  sudo service docker.youtrack start
  ```
