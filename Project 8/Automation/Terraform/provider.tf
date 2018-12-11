provider "aws" {
  }
resource "aws_vpc" "potatovpc" {
  cidr_block       = "172.31.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "potatovpc"
  }
}
resource "aws_internet_gateway" "potatogw" {
  vpc_id = "${aws_vpc.potatovpc.id}"

  tags {
    Name = "potatogw"
  }
}
resource "aws_subnet" "potatops1" {
  vpc_id     = "${aws_vpc.potatovpc.id}"
  cidr_block = "172.31.0.0/22"
  availability_zone = "us-west-2a"

  tags {
    Name = "potatops1"
  }
}
resource "aws_subnet" "potatops2" {
  vpc_id     = "${aws_vpc.potatovpc.id}"
  cidr_block = "172.31.4.0/22"
  availability_zone = "us-west-2b"


  tags {
    Name = "potatops2"
  }
}
resource "aws_subnet" "potatops3" {
  vpc_id     = "${aws_vpc.potatovpc.id}"
  cidr_block = "172.31.8.0/22"
    availability_zone = "us-west-2c"


  tags {
    Name = "potatops3"
  }
}
resource "aws_route_table" "potatoprt" {
  vpc_id = "${aws_vpc.potatovpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.potatogw.id}"
  }


  tags {
    Name = "potatoprt"
  }
}
resource "aws_route_table_association" "potatopa1" {
  subnet_id      = "${aws_subnet.potatops1.id}"
  route_table_id = "${aws_route_table.potatoprt.id}"
}
resource "aws_route_table_association" "potatopa2" {
  subnet_id      = "${aws_subnet.potatops2.id}"
  route_table_id = "${aws_route_table.potatoprt.id}"
}
resource "aws_route_table_association" "potatopa3" {
  subnet_id      = "${aws_subnet.potatops3.id}"
  route_table_id = "${aws_route_table.potatoprt.id}"
}
resource "aws_subnet" "potatoprs1" {
  vpc_id     = "${aws_vpc.potatovpc.id}"
  cidr_block = "172.31.16.0/20"
    availability_zone = "us-west-2a"


  tags {
    Name = "potatoprs1"
  }
}
resource "aws_subnet" "potatoprs2" {
  vpc_id     = "${aws_vpc.potatovpc.id}"
  cidr_block = "172.31.32.0/20"
    availability_zone = "us-west-2b"


  tags {
    Name = "potatoprs2"
  }
}
resource "aws_subnet" "potatoprs3" {
  vpc_id     = "${aws_vpc.potatovpc.id}"
  cidr_block = "172.31.48.0/20"
    availability_zone = "us-west-2c"


  tags {
    Name = "potatoprs3"
  }
}
resource "aws_route_table" "potatoprrt" {
  vpc_id = "${aws_vpc.potatovpc.id}"
	route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }
  tags {
    Name = "potatoprrt"
  }
}
resource "aws_route_table_association" "potatopra1" {
  subnet_id      = "${aws_subnet.potatoprs1.id}"
  route_table_id = "${aws_route_table.potatoprrt.id}"
}
resource "aws_route_table_association" "potatopra2" {
  subnet_id      = "${aws_subnet.potatoprs2.id}"
  route_table_id = "${aws_route_table.potatoprrt.id}"
}
resource "aws_route_table_association" "potatopra3" {
  subnet_id      = "${aws_subnet.potatoprs3.id}"
  route_table_id = "${aws_route_table.potatoprrt.id}"
}