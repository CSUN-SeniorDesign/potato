## Setting up TLS for YouTrack
https://www.jetbrains.com/help/youtrack/standalone/tls-keystores-and-certificates-for-server.html

1. Run this command:
  ```
  openssl genrsa -out YouTrack_Server_TLS.pem 2048
  ```

2. Run this command:
  ```
  openssl req -new -key YouTrack_Server_TLS.pem -out YouTrack_Server_TLS_req.csr
  ```

  Use the FQDN of your server
  ```
  https://<FQDN of your server>:<port>/
  https://13.58.141.53:8443/
  ```

3. Create a file called v3.ext
  ```
  sudo nano v3.ext
  ```

  and put this into the file:

  ```
  authorityKeyIdentifier=keyid,issuer
  basicConstraints=CA:FALSE
  keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
  ```

4. Run this command:
  ```
  openssl x509 -in YouTrack_Server_TLS_req.csr -out YouTrack_Server_TLS_cert.pem -req -signkey YouTrack_Server_TLS.pem -days 3650 -extfile v3.ext
  ```

5. Validate with these commands:
  ```
  openssl x509 -noout -text -in cert.key | grep Subject:
  openssl x509 -noout -text -in cert.key | grep CN:
  ```

  Results of running those commands:
  ```
  openssl x509 -noout -text -in YouTrack_Server_TLS_cert.pem | grep Subject:

  Subject: C = US, ST = CA, L = Northridge, O = Irrigation, CN = https://13.58.141.53:8443, emailAddress = skarim3000@gmail.com
  ```

  ```
  openssl x509 -noout -text -in YouTrack_Server_TLS_cert.pem | grep CN

  Issuer: C = US, ST = CA, L = Northridge, O = Irrigation, CN = https://13.58.141.53:8443, emailAddress = skarim3000@gmail.com
          Subject: C = US, ST = CA, L = Northridge, O = Irrigation, CN = https://13.58.141.53:8443, emailAddress = skarim3000@gmail.com
                  DirName:/C=US/ST=CA/L=Northridge/O=Irrigation/CN=https://13.58.141.53:8443/emailAddress=skarim3000@gmail.com
  ```

6. Run these commands:
  ```
  sudo chown youtrack:youtrack YouTrack_Server_TLS.pem
  sudo chown youtrack:youtrack YouTrack_Server_TLS_cert.pem
  ```

7.  Run these commands:
  ```
  sudo chmod 700 YouTrack_Server_TLS.pem
  sudo chmod 700 YouTrack_Server_TLS_cert.pem
  ```
