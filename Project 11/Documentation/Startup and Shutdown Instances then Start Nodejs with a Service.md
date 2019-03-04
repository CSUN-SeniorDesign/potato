## Starting up Instances
1. In AWS Lambda, create a function using Python 2.7

2. Input this for the Function code:
  ```
  import json
  import boto3

  region = 'us-east-2'
  instances = ['i-0c69aa95a162790a7']

  def lambda_handler(event, context):
      ec2 = boto3.client('ec2', region_name=region)
      ec2.start_instances(InstanceIds=instances)
      print 'Started your instances: ' + str(instances)
  ```

## Updating DNS with Cloudflare API
1. In AWS Lambda, create a function using Python 2.7

2. Input this for the function code:
  ```
  import json
  import boto3
  import time
  from botocore.vendored import requests

  region = 'us-east-2'
  instances = ['i-0c69aa95a162790a7']

  ec2obj = boto3.resource('ec2', region_name=region)
  ec2instance = ec2obj.Instance(id=instances[0])
  print ec2instance.public_ip_address

  def lambda_handler(event, context):
    headers = {
        'X-Auth-Email': 'shahid.karim.30@my.csun.edu',
        'X-Auth-Key': '296d4f63ce76ede9a6fae9daa018fce039fc0',
        'Content-Type': 'application/json'
    }

    data = '{"type":"A","name":"irrigationproject.xyz","content":"' + ec2instance.public_ip_address + '","ttl":60,"proxied":true}'

    response = requests.put('https://api.cloudflare.com/client/v4/zones/459ef4596b167bac060bf69c4bce287c/dns_records/a26a014b96a7b4a036e8afc1e016fbf6', headers=headers, data=data)

    print response
    print 'Updated your DNS.'
  ```

## Shutting down Instances
1. In AWS Lambda, create a function using Python 2.7

2. Input this for the Function code:
  ```
  import json
  import boto3

  # Enter the region your instances are in. Include only the region without specifying Availability Zone; e.g., 'us-east-1'
  region = 'us-east-2'
  # Enter your instances here: ex. ['X-XXXXXXXX', 'X-XXXXXXXX']
  instances = ['i-0c69aa95a162790a7']

  def lambda_handler(event, context):
      ec2 = boto3.client('ec2', region_name=region)
      ec2.stop_instances(InstanceIds=instances)
      print 'stopped your instances: ' + str(instances)
  ```

## Starting Nodejs Using a Service
1. Create a .service file
  ```
    sudo nano startnodejs.service
  ```

2. Input the following in the service file:
  ```
  [Unit]
  Description=Starts Nodejs as a service

  [Service]
  ExecStart=/home/ubuntu/startnodejs.sh

  [Install]
  WantedBy=multi-user.target
  ```

3. Move the service file to the correct directory.
```
sudo chmod 777 startnodejs.service && sudo mv startnodejs.service /etc/systemd/system/startnodejs.service
```

4. Create startnodejs.sh
```
  sudo nano /home/ubuntu/startnodejs.sh
```

5. Put the following in startnodejs.sh
```
  #!/bin/sh
  cd /home/ubuntu/login-portal && \
  sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000 && \
  sudo iptables-save && \
  npm start
```

6. Give the script that starts Nodejs execute permission.
```
chmod u+x /home/ubuntu/startnodejs.sh
```

7. Start then enable the service.
```
sudo systemctl start startnodejs.service
sudo systemctl enable startnodejs.service
```

8. Check for all enabled systemctl unit files
```
systemctl list-unit-files | grep enabled
```

9. Check for all running systemctl unit files
```
systemctl | grep running
```
