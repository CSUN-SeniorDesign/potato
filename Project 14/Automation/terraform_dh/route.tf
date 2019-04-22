resource "aws_route_table" "irrigation-route" {
  vpc_id		="${aws_vpc.irrigation-vpc.id}"
  
  route {
	cidr_block	= "0.0.0.0/0"
	gateway_id 	= "${aws_internet_gateway.irrigation-gateway.id}"
  }
  tags {
	name = "irriagtion-route"
  }
}


resource "aws_route_table" "irrigation-route2" {
  vpc_id	= "${aws_vpc.irrigation-vpc.id}"
  tags {
	name = "irrigation-route2"
  }
}

resource "aws_route_table" "irrigation-route3" {
  vpc_id	= "${aws_vpc.irrigation-vpc.id}"
  route {
	cidr_block = "0.0.0.0/0"
	instance_id = "${aws_instance.irrigation-nat.id}"
  }
  tags {
	name = "irrigation-route3"
  }
}
