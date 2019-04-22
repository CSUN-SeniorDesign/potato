resource "aws_security_group" "irrigation-bastion-security" {
  name			= "irrigation-bastion"
  description		= "Allow SSH traffic to Bastion"
  vpc_id		= "${aws_vpc.irrigation-vpc.id}"
  ingress {
	from_port	= 22
	to_port		= 22
	protocol	= "tcp"
	cidr_blocks	= ["0.0.0.0/0"]
  }
  egress {
	from_port	= 0
	to_port		= 0
	protocol	= "-1"
	cidr_blocks	= ["0.0.0.0/0"]
  }
}

resource "aws_instance" "irrigation-bastion" {
  ami			= "ami-51537029"
  availability_zone	= "us-west-2a"
  instance_type		= "t2.micro"
  key_name		= "irrigation"
  subnet_id		= "${aws_subnet.irrigation-subnet-b2.id}"
  associate_public_ip_address = "true"
  vpc_security_group_ids = ["${aws_security_group.irrigation-bastion-security.id}"]
  depends_on		= ["aws_security_group.irrigation-bastion-security"]
  tags {
	name 		= "irrigation-bastion"
  }
}
