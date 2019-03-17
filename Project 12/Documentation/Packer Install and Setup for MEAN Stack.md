#### Installing Packer
1. Go to https://www.packer.io/
2. Add the packer.exe to PATH

#### Setting up Packer
##### Creating the workspace
1. Create a folder and name it something like "Packer Workspace"

##### Creating the AMI
1. Create a json file named mean.json
2. Put the following inside that file
```
{
    "variables": {
        "aws_access_key": "",
        "aws_secret_key": "",
        "instance_type": "t3.medium",
        "region": "us-east-2"
    },
    "builders": [{
      "type": "amazon-ebs",
      "access_key": "{{user `aws_access_key`}}",
      "secret_key": "{{user `aws_secret_key`}}",
      "region": "{{user `region`}}",
      "source_ami_filter": {
        "filters": {
          "virtualization-type": "hvm",
          "name": "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*",
          "root-device-type": "ebs"
        },
        "owners": ["099720109477"],
        "most_recent": true
      },
      "instance_type": "{{user `instance_type`}}",
      "ssh_username": "ubuntu",
      "ami_name": "packer-mean-irrigation {{timestamp}}"
    }],
    "provisioners": [{
        "type": "shell",
        "script": "setup-mean-irrigation.sh"
    }]
}
```
3. Create a sh file named setup-mean-irrigation.sh
4. Put the following inside that file
```
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y curl git
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs
git clone https://github.com/CSUN-Irrigation/MEAN-Shahid-Software-Irrigation
cd MEAN-Shahid-Software-Irrigation
npm install
export OKTA_ORG_URL="https://dev-423841.okta.com"
export OKTA_TOKEN=00ZSLP0Jm4ytPKAA-c_ZDN6WDM_dd8evc3ABs04p8S
export OKTA_CLIENT_ID=0oabr9jsqpLUEqRIy356
export OKTA_CLIENT_SECRET=hCqri2hT_GUy1i-kYbueW9gTr8sm1n0w1M-RS49H
export SECRET=aweoihngaw4g2w34908h23wt4gawaweoik
export OKTA_APPBASEURL=https://irrigationproject.xyz/
export OKTA_CALLBACK_URI=https://irrigationproject.xyz/dashboard
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000
sudo iptables-save
npm start > ~/log &
```
5. Run the following command to create the AMI
```
packer build mean.json
```
