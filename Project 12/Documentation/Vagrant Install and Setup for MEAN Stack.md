# IMPORTANT NOTE:
If there is a publickey issue when trying to ```vagrant ssh``` do the following on Windows:
1. Open Settings
2. Go to Apps
3. Go to Apps and Features
4. Go to Optional Features
5. Uninstall OpenSSH

#### Installing Vagrant
1. Go to https://www.vagrantup.com/
2. Click the download button and select the operating system.
3. Install the program with the default settings.
4. Once the installation has finshed, open a terminal or cmder.
5. Type ```vagrant --version``` in order to check that it has installed and that you have the proper version.

#### Setting up Vagrant
##### Creating the workspace
1. Create a folder and name it something like "Vagrant Workspace"

##### Downloading a box
1. Change directory into that folder.
2. Go to https://app.vagrantup.com/boxes/search and choose a virtual machine suited to whatever task you need it for.
3. For a general purpose ubuntu 18.04 machine, run the following:
```
  vagrant init ubuntu/bionic64
```

#### Using Vagrant
1. Open a terminal or cmder.
2. Change directory to the workspace directory you made in the previous step.
3. Run the following to start Vagrant with the default settings found the in Vagrantfile downloaded in the previous step:
```
  vagrant up
```
4. In order to provision the vm using shell, change the following area in the Vagrantfile:
```
config.vm.provision "shell", inline: <<-SHELL
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y curl git
  curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
  sudo apt-get install -y nodejs
  git clone https://github.com/CSUN-Irrigation/MEAN-Shahid-Software-Irrigation
  cd MEAN-Shahid-Software-Irrigation
  npm install
  export OKTA_ORG_URL="https://dev-421.okta.com"
  export OKTA_TOKEN=00ZSLP0Jm8S
  export OKTA_CLIENT_ID=0356
  export OKTA_CLIENT_SECRET=h-RS49H
  export SECRET=aweoik
  export OKTA_APPBASEURL=https://irrigationproject.xyz/
  export OKTA_CALLBACK_URI=https://irrigationproject.xyz/dashboard
  sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000
  sudo iptables-save
  npm start > ~/log &
SHELL
```
5. If any changes are made to the vm while the vm is running, use the following command to update the vm.
```
  vagrant reload
```

#### Using Vagrant with AWS
1. Download AWS CLI
2. Run the following to set up AWS CLI
```
  aws configure --profile default
```
3. On Windows run
```
  set AWS_DEFAULT_PROFILE=default
```
On Linux, macOS, or Unix run
```
  export AWS_DEFAULT_PROFILE=default
```
4. Install ruby then install vagrant-aws-0.8.0.gem
```
  https://github.com/bdwyertech/vagrant-aws

  https://github.com/bdwyertech/vagrant-aws/releases/tag/v0.8.0-bdwyertech

  gem install vagrant-aws-0.8.0.gem
```
5. Create the following Vagrantfile
```
  # -*- mode: ruby -*-
  # vi: set ft=ruby :

  # Require the AWS provider plugin
  require 'vagrant-aws'

  # Create and configure the AWS instance(s)
  Vagrant.configure('2') do |config|

    # Use dummy AWS box
    config.vm.box = 'aws-dummy'

    #config.aws_credentials.profile = "default"

    # Specify AWS provider configuration
    config.vm.provider 'aws' do |aws, override|
      aws.aws_dir = "C:/Users/h1dde/.aws"
      #aws.aws_profile = "default"

      # Read AWS authentication information from environment variables
      aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
      aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']

      # Specify SSH keypair to use
      aws.keypair_name = 'irrigation'

      # Specify region, AMI ID, and security group(s)
      aws.region = 'us-east-2'
      aws.ami = 'ami-0c55b159cbfafe1f0'
      aws.instance_type = 't3.medium'
      aws.security_groups = [ 'vagrant-demo' ]

      aws.tags = {
        'Name' => 'Vagrant-Demo',
        'type' => 'mean'
      }

      aws.instance_ready_timeout = 30

      # Specify username and private key path
      override.ssh.username = 'ubuntu'
      override.ssh.private_key_path = 'C:/Users/h1dde/.ssh/irrigation.pem'
    end

    config.vm.provision "shell", inline: <<-SHELL
      apt-get update -y
      apt-get upgrade -y
    SHELL
  end
```
6. Run the following to start the instance
```
  vagrant up
```
