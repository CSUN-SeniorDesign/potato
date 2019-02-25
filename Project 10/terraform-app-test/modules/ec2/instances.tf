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
