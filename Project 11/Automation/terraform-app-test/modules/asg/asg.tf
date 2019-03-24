resource "aws_launch_configuration" "ASG" {
name = "ASG"
image_id = "ami-0bbe6b35405ecebdb"
instance_type = "t2.micro"
security_groups = ["${var.linux_security_group}"]
# key_name = "newpair"	
lifecycle {
   create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "bar" {
  name                 = "ubuntunginxdatadog"
  launch_configuration = "${aws_launch_configuration.ASG.name}"
  vpc_zone_identifier       = ["${var.subnets}"]

  min_size             = 1
  max_size             = 2

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.bar.id}"
  alb_target_group_arn   = "${var.alb_target_group_arn}"
}