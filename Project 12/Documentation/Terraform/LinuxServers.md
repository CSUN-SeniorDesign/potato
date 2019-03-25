Setup EC2 (Linux Servers)

	Overview:
		By the end of this tutorial the reader should be to able to setup following in AWS using just Terraform:

			- Create 2 linux servers
		
	Prerequisites:
		Computer with Windows Operating System
	Steps:
		1. This first step will create the linux security group with the allowed ports and ip address they are able to use.
				resource "aws_security_group" "linux-securitygroup" {  
				  name        = "linux"
				  description = "Allow SSH traffic to bastion"
				  vpc_id      = "${var.vpc_id}"

				  ingress {
					from_port   = 22
					to_port     = 22
					protocol    = "tcp"
					cidr_blocks = ["172.31.0.0/16"]
				  }
				  ingress {
					from_port   = 80
					to_port     = 80
					protocol    = "tcp"
					cidr_blocks = ["172.31.0.0/16"]
				  }
				  egress {
					from_port   = 0
					to_port     = 0
					protocol    = "-1"
					cidr_blocks = ["0.0.0.0/0"]
				  }
				 }	

		2. This will create the private subnet linux servers.
			
				resource "aws_instance" "web" {
			#	  count			= "${var.ec2_count}"
				  ami           = "${var.ami_id}"
				  instance_type = "${var.instance_type}"
				  subnet_id 	= "${var.subnet_id}"
				  tags = {
					Name = "Demo10"
				  }
				}
				resource "aws_instance" "web2" {
			#	  count			= "${var.ec2_count}"
				  ami           = "${var.ami_id}"
				  instance_type = "${var.instance_type}"
				  subnet_id 	= "${var.subnet_id}"
				  tags = {
					Name = "Demo11"
				  }
				}