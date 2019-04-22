resource "aws_internet_gateway" "irrigation-gateway" {
  vpc_id = "${aws_vpc.irrigation-vpc.id}"
  
  tags {
       name = "irrigation-gateway"
 }
}

