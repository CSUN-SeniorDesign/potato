	provider "aws" {
		region		= "us-west-2"
    }
	module "my_vpc" {
		source		= "../modules/vpc"
		vpc_cidr	= "172.31.0.0/16"
		tenancy		= "default"
		vpc_id		= "${module.my_vpc.vpc_id}"
		subnet_cidr		= "172.31.0.0/24"
		subnet_cidr1	= "172.31.1.2/24"
		subnet_cidr2	= "172.31.2.3/24"
		availability_zone  = "us-west-2a"
		availability_zone1 = "us-west-2b"
		availability_zone2 = "us-west-2c"

	}
	module "my_ec2" {
		source			= "../modules/ec2"
#		ec2_count		=	1
		ami_id			= "ami-0bbe6b35405ecebdb"
		instance_type	= "t2.micro"
		subnet_id		= "${module.my_vpc.subnet_id}"
	}
	module "my_nat" {
		source		= "../modules/nat"
		vpc_id		= "${module.my_vpc.vpc_id}"
		subnet_id = "${module.my_vpc.subnet_id}"
	}

	module "my_s3bucket" {
		source			= "../modules/s3bucket"
		bucket			= "potatobucket5"
	}
	module "my_s3backend" {
		source			= "../modules/s3backend"
	}
	module "my_bastion" {
		source			= "../modules/bastion"
		vpc_id			= "${module.my_vpc.vpc_id}"
		subnet_id = "${module.my_vpc.subnet_id_ps1}"
	}

	module "my_alb" {
		source			= "../modules/alb"
		vpc_id		  = "${module.my_vpc.vpc_id}"
		subnets		  = ["${module.my_vpc.subnets}"]
		targetid		= "${module.my_ec2.instance_one}"
		targetid1		= "${module.my_ec2.instance_two}"
	}	

#	module "my_iam" {
#		source			= "../modules/iam"
#	}