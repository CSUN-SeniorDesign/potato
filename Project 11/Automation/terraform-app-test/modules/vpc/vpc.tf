	resource "aws_vpc" "main" {
	  cidr_block       = "${var.vpc_cidr}"
	  instance_tenancy = "${var.tenancy}"

	  tags = {
		Name = "main"
	  }
	}

	resource "aws_subnet" "main" {
	  vpc_id     = "${var.vpc_id}"
	  cidr_block = "${var.subnet_cidr}"
		availability_zone = "${var.availability_zone}"

	  tags = {
		Name = "Main"
	  }
	}

	resource "aws_subnet" "PS1" {
	  vpc_id     = "${var.vpc_id}"
	  cidr_block = "${var.subnet_cidr1}"
		availability_zone = "${var.availability_zone1}"

	  tags = {
		Name = "PS1"
	  }
	}

	resource "aws_subnet" "PS2" {
	  vpc_id     = "${var.vpc_id}"
	  cidr_block = "${var.subnet_cidr2}"
		availability_zone = "${var.availability_zone2}"

	  tags = {
		Name = "PS2"
	  }
	}
	resource "aws_internet_gateway" "IG" {
  	vpc_id = "${var.vpc_id}"

  tags {
    Name = "IG"
  }
	}
	resource "aws_route_table" "PRT" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IG.id}"
  }


  tags {
    Name = "PRT"
  }
	}
	output "vpc_id" {
	  value		= "${aws_vpc.main.id}"
	}
	
	output "subnet_id" {
	  value = "${aws_subnet.main.id}"
	}

	output "subnet_id_ps1" {
	  value = "${aws_subnet.PS1.id}"
	}

	output "subnet_id_ps2" {
	  value = "${aws_subnet.PS2.id}"
	}

	output "subnets" {
	  value = ["${aws_subnet.main.id}","${aws_subnet.PS1.id}","${aws_subnet.PS2.id}"]
	}




	
