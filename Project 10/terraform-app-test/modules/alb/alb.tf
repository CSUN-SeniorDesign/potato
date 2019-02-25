 resource "aws_alb" "potatoalb"{
 name = "potatoalb"
 internal = false
 security_groups = ["${aws_security_group.potatoalbsg.id}"]
 depends_on = ["aws_security_group.potatoalbsg"]
 subnets = ["${var.subnets}"]
 }
resource "aws_security_group" "potatoalbsg" {  
  name        = "potatoalbsg"
  description = "allow port 80 access"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
        Name = "potato alb"
    }
  
 }

 
 resource "aws_alb_target_group" "potatoalbtg" {
	name	= "potatoalbtg"
	vpc_id	= "${var.vpc_id}"
	port	= "80"
	protocol	= "HTTP"
	depends_on = ["aws_alb.potatoalb"]
	health_check {
                path = "/"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 5
                unhealthy_threshold = 2
                interval = 30
                timeout = 5
                matcher = "200"
        }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.potatoalb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.potatoalbtg.arn}"
  }
}
resource "aws_alb_target_group_attachment" "potatoalbattach1" {
  target_group_arn = "${aws_alb_target_group.potatoalbtg.arn}"
  target_id      = "${var.targetid}"
  port             = 80
  depends_on = ["aws_alb.potatoalb"]
}
resource "aws_alb_target_group_attachment" "potatoalbattach2" {
  target_group_arn = "${aws_alb_target_group.potatoalbtg.arn}"
  target_id      = "${var.targetid1}"
  port             = 80
  depends_on = ["aws_alb.potatoalb"]
}
resource "aws_route53_record" "alias_route53_record" {
  zone_id = "Z3VF4R4JENHI7B"
   name   = "honeyroselove.xyz"
  type    = "A"

  alias {
    name                   = "${aws_alb.potatoalb.dns_name}"
    zone_id                = "${aws_alb.potatoalb.zone_id}"
    evaluate_target_health = true
  }
}