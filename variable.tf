variable "region" {
  default = "us-east-1"

}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr_block" {
  default = "10.0.2.0/24"
}

variable "public_subnet_3_cidr_block" {
  default = "10.0.3.0/24"
}

variable "private_subnet_1_cidr_block" {
  default = "10.0.5.0/24"
}

variable "private_subnet_2_cidr_block" {
  default = "10.0.6.0/24"
}

variable "private_subnet_3_cidr_block" {
  default = "10.0.7.0/24"
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_ami" {
  default = "ami-0bef6cc322bfff646"
}

variable "key-name" {
  default = "XXXXXXXXXX"
}

variable "domain_name" {
  default = "gokhanyardimci.com."
}

variable "www_domain_name" {
  default = "www.gokhanyardimci.com."
}

variable "aws_acm_certificate_name" {
  default = "gokhanyardimci.com"
}

variable "alter_domain_names" {
  type    = list(string)
  default = ["gokhanyardimci.com", "www.gokhanyardimci.com"]
}
