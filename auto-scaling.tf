resource "aws_autoscaling_group" "Terraform-Auto-Scaling-Group" {
  name                      = "Terraform-Auto-Scaling-Group"
  max_size                  = 4
  min_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.Terraform-Private-Subnet-1.id, aws_subnet.Terraform-Private-Subnet-2.id, aws_subnet.Terraform-Private-Subnet-3.id]

  launch_template {
    id      = aws_launch_template.Terraform-Launch-Template.id
    version = aws_launch_template.Terraform-Launch-Template.latest_version
  }
}

resource "aws_autoscaling_attachment" "Terraform-ASG-Attachment" {
  autoscaling_group_name = aws_autoscaling_group.Terraform-Auto-Scaling-Group.id
  lb_target_group_arn    = aws_lb_target_group.Terraform-Target-Group.arn
}
