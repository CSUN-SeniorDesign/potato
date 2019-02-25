	variable "vpc_cidr" {
		default = "172.31.0.0/16"
	}
	
	variable "tenancy" {
		default = "dedicated"
	}
	
	variable "vpc_id" {}
	
	variable "subnet_cidr" {
		default = "172.31.0.0/24"
	}

	variable "subnet_cidr1" {
		default = "172.31.1.2/24"
	}

	variable "subnet_cidr2" {
		default = "172.31.2.3/24"
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