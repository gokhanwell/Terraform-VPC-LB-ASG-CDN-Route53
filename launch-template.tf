resource "aws_security_group" "Terraform-Launch-Template-Sec-Gr" {
  name   = "Terraform-Launch-Template-Sec-Gr"
  vpc_id = aws_vpc.Terraform-VPC.id
  tags = {
    "Name" = "Terraform-Launch-Template-Sec-Gr"
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [data.aws_security_group.Terraform.id]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [data.aws_security_group.Terraform.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


data "aws_security_group" "Terraform" {
  id = aws_security_group.Terraform-Application-Lb-Sec-Gr.id
}


resource "aws_launch_template" "Terraform-Launch-Template" {
  name                   = "Terraform-Launch-Template"
  image_id               = var.ec2_ami
  instance_type          = var.ec2_type
  key_name               = var.key-name
  vpc_security_group_ids = [aws_security_group.Terraform-Launch-Template-Sec-Gr.id]
  # instance_market_options {   #optional
  #   market_type = "spot"
  # }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Terraform-Launch-Template"
    }
  }

  user_data = filebase64("${path.module}/launch-template.sh")
}
