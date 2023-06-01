resource "aws_security_group" "Terraform-Application-Lb-Sec-Gr" {
  name   = "Terraform-Application-Lb-Sec-Gr"
  vpc_id = aws_vpc.Terraform-VPC.id
  tags = {
    "Name" = "Terraform-Application-Lb-Sec-Gr"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "Terraform-Target-Group" {
  name     = "Terraform-Target-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Terraform-VPC.id

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 10
    matcher             = 200
  }
  tags = {
    "Name" = "Terraform-Target-Group"
  }
}

resource "aws_lb" "Terraform-Application-Lb" {
  name               = "Terraform-Application-Lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Terraform-Application-Lb-Sec-Gr.id]
  subnets            = [aws_subnet.Terraform-Public-Subnet-1.id, aws_subnet.Terraform-Public-Subnet-2.id, aws_subnet.Terraform-Public-Subnet-3.id]
  # enable_deletion_protection = true
  tags = {
    Environment = "Terraform-Application-Lb"
  }
}

resource "aws_lb_listener" "Terraform-Application-Lb-HTTP" {
  load_balancer_arn = aws_lb.Terraform-Application-Lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Terraform-Target-Group.arn
  }
}
