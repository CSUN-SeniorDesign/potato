resource "aws_security_group" "irrigation-nat-security" {
  name			= "irrigation-nat"
  description		= "Allow traffic to pass from the private subnet to the internet"
  vpc_id		= "${aws_vpc.irrigation-vpc.id}"
  ingress {
	from_port	= 80
	to_port		= 80
	protocol	= "tcp"
	cidr_blocks	= ["172.31.16.0/20", "172.31.32.0/20", "172.31.48.0/20"]
  }
  ingress {
	from_port	= 443
	to_port		= 443
	protocol	= "tcp"
  	cidr_blocks	= ["172.31.16.0/20", "172.31.32.0/20", "172.31.48.0/20"]
  }
 ingress {
	from_port	= 22
	to_port		= 22
	protocol	= "tcp"
	cidr_blocks	= ["0.0.0.0/0"]
  }
ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = ["0.0.0.0/0"]
  }

egress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
  }
egress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
  }
egress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["173.31.0.0/16"]
  }
egress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
	name = "irrigation-nat-security"
  }
}

resource "aws_instance" "irrigation-nat" {
  ami			= "ami-40d1f038"
  availability_zone	= "us-west-2a"
  instance_type		= "t2.micro"
  key_name		= "irrigation"
  subnet_id		= "${aws_subnet.irrigation-subnet-a1.id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.irrigation-nat-security.id}"]
  source_dest_check 	= false
  depends_on		= ["aws_security_group.irrigation-nat-security"]
  tags {
	name = "irrigation-nat-instance"
  }
}



