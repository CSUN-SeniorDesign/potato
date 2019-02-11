	provider "aws" {
		region		= "us-west-2"
    }
	module "my_vpc" {
		source		= "../modules/vpc"
		vpc_cidr	= "172.31.0.0/22"
		tenancy		= "default"
		vpc_id		= "${module.my_vpc.vpc_id}"
		subnet_cidr	= "172.31.1.0/22"
	}
	module "my_ec2" {
		source			= "../modules/ec2"
		ec2_count		=	1
		ami_id			= "ami-0bbe6b35405ecebdb"
		instance_type	= "t2.micro"
		subnet_id		= "${module.my_vpc.subnet_id}"
	}