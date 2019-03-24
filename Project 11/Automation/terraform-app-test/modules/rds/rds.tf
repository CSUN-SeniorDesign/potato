resource "aws_db_instance" "mydb1" {
  allocated_storage        = 10 # gigabytes
  engine                   = "mysql"
  engine_version           = "5.7"
  identifier               = "mydb1"
  instance_class           = "db.t2.micro"
  name                     = "mydb1"
  parameter_group_name     = "default.mysql5.7"
  password                 = "passfornow"
  storage_type             = "gp2"
  username                 = "mydb1"
  vpc_security_group_ids   = ["${aws_security_group.mydb1.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.userdb_subnet_group.id}"
  skip_final_snapshot =  true
}
resource "aws_db_subnet_group" "userdb_subnet_group" {
name = "userdb_subnet_group"
description = "user db subnet group"
subnet_ids = ["${var.rds_subnet}"]
tags = {
Name = "subnet_rds"
}
}
resource "aws_security_group" "mydb1" {
  name = "mydb1"

  description = "RDS postgres servers (terraform-managed)"
  vpc_id = "${var.vpc_id}"

  # Only postgres in
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}