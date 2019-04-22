resource "aws_subnet" "irrigation-subnet-a1" {
  vpc_id		= "${aws_vpc.irrigation-vpc.id}"
  cidr_block		= "172.31.0.0/22"
  availability_zone	= "us-west-2a"

  tags {
	name = "irrigation-a1"
  }
}

resource "aws_subnet" "irrigation-subnet-b1" {
  vpc_id                = "${aws_vpc.irrigation-vpc.id}"
  cidr_block            = "172.31.4.0/22"
  availability_zone     = "us-west-2a"

  tags {
        name = "irrigation-b1"
  }
}


resource "aws_subnet" "irrigation-subnet-c1" {
  vpc_id                = "${aws_vpc.irrigation-vpc.id}"
  cidr_block            = "172.31.8.0/22"
  availability_zone     = "us-west-2a"

  tags {
        name = "irrigation-c1"
  }
}


resource "aws_subnet" "irrigation-subnet-a2" {
  vpc_id                = "${aws_vpc.irrigation-vpc.id}"
  cidr_block            = "172.31.16.0/20"
  availability_zone     = "us-west-2a"

  tags {
        name = "irrigation-a2"
  }
}


resource "aws_subnet" "irrigation-subnet-b2" {
  vpc_id                = "${aws_vpc.irrigation-vpc.id}"
  cidr_block            = "172.31.32.0/20"
  availability_zone     = "us-west-2a"

  tags {
        name = "irrigation-b2"
  }
}

resource "aws_subnet" "irrigation-subnet-c2" {
  vpc_id                = "${aws_vpc.irrigation-vpc.id}"
  cidr_block            = "172.31.48.0/20"
  availability_zone     = "us-west-2a"

  tags {
        name = "irrigation-c2"
  }
}

resource "aws_route_table_association" "irrigation-subnet-aa1" {
  subnet_id		= "${aws_subnet.irrigation-subnet-a1.id}"
  route_table_id	= "${aws_route_table.irrigation-route.id}"
}

resource "aws_route_table_association" "irrigation-subnet-ab1" {
  subnet_id             = "${aws_subnet.irrigation-subnet-b1.id}"
  route_table_id        = "${aws_route_table.irrigation-route.id}"
}

resource "aws_route_table_association" "irrigation-subnet-ac1" {
  subnet_id             = "${aws_subnet.irrigation-subnet-c1.id}"
  route_table_id        = "${aws_route_table.irrigation-route.id}"
}

resource "aws_route_table_association" "irrigation-subnet-aa2" {
  subnet_id             = "${aws_subnet.irrigation-subnet-a2.id}"
  route_table_id        = "${aws_route_table.irrigation-route2.id}"
}

resource "aws_route_table_association" "irrigation-subnet-ab2" {
  subnet_id             = "${aws_subnet.irrigation-subnet-b2.id}"
  route_table_id        = "${aws_route_table.irrigation-route2.id}"
}

resource "aws_route_table_association" "irrigation-subnet-ac2" {
  subnet_id             = "${aws_subnet.irrigation-subnet-c2.id}"
  route_table_id        = "${aws_route_table.irrigation-route2.id}"
}

