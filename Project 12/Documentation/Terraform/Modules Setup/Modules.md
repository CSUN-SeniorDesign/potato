Setup Modules to run terraform files 
	- This creates a reusable environment that makes the terraform files able to used again
	Overview:
		By the end of this tutorial the reader should be to able to setup following in AWS using just Terraform:
			- Modules
	Prerequisites:
		Computer with Windows Operating System
			- variable terraform files
	Steps:
		1. Anything in the terraform files like vpc id or cidr or anything related to setting should be placed as a variable so that the module can be the form to set it up:
		2. Create a .tf file for the Module file
		3. Heres an example of how a module resource should look like once the variables are added:
		
				module "my_vpc" {
					source		= "../modules/vpc"
					vpc_cidr	= "172.31.0.0/22"
					tenancy		= "default"
					vpc_id		= "${module.my_vpc.vpc_id}"
					subnet_cidr		= "172.31.0.0/24"
					subnet_cidr1	= "172.31.1.2/24"
					subnet_cidr2	= "172.31.2.3/24"
					availability_zone  = "us-west-2a"
					availability_zone1 = "us-west-2b"
					availability_zone2 = "us-west-2c"

				}
					
		*Extra: Any Variable not listed in the module but listed on the var.tf will remain default
		- Needs to know for modules:
			"${module.my_vpc.vpc_id}"  - is a form to call out an name or item from another terraform file.
				- In order to do this you will need to use the output source (example):
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
				- This will be placed in the actual terraform files in order to attain it in the module after
								