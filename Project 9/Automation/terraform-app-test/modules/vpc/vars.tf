	variable "vpc_cidr" {
		default = "10.0.0.0/16"
	}
	
	variable "tenancy" {
		default = "dedicated"
	}
	
	variable "vpc_id" {}
	
	variable "subnet_cidr" {
		default = "10.0.1.0/24"
	}

	variable "availability_zone" {
		default = "us-west-2a"
	}

	variable "availability_zone1" {
		default = "us-west-2b"
	}

	variable "availability_zone2" {
		default = "us-west-2c"
	}