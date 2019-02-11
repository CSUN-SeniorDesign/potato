	resource "aws_instance" "web" {
	  count			= "${var.ec2_count}"
	  ami           = "${var.ami_id}"
	  instance_type = "${var.instance_type}"
	  subnet_id 	= "${var.subnet_id}"

		# locally install this but i believe it requires ssh
		#	provisioner "local-exec" {
    #		command = "sudo apt-get update && sudo apt-get upgrade -y"
    #
  	#	}

	  tags = {
		Name = "Demo10"
	  }
	}