# Security Group Resources
resource "aws_security_group" "alb_security_group" {
  name        = "${var.name}-alb-security-group"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from Internet"
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
}

resource "aws_security_group" "asg_security_group" {
  name        = "${var.name}-asg-security-group"
  description = "ASG Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch Template and Security Group
resource "aws_launch_template" "launch_template" {
  name          = "${var.name}-aws-launch-template"
  image_id      = var.user_specified_ami_id != "" ? var.user_specified_ami_id : var.default_ami_id
  instance_type = "t2.micro"

  iam_instance_profile {
    name = "${var.name}-instance-profile"
  }

  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }
  user_data = filebase64("${path.module}/userdata.sh")

  tags = {
    Name = "${var.name}-LaunchTemplate"
  }
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.lb_target_group.arn]
  name                = "${var.name}-ec2-asg"

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "${var.name}-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "${var.name}-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
