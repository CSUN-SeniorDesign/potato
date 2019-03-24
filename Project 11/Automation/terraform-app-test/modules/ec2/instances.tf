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
	output "instance_one" {
	  value = "${aws_instance.web.id}"
	}

	output "instance_two" {
	  value = "${aws_instance.web2.id}"
	}
	output "linux_security_group" {
	  value = "${aws_security_group.linux-securitygroup.id}"
	}