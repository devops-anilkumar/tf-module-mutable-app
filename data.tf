# RETRIVES THE INFORMATION FROM THE REMOTE STATE FILE  VPC
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "state-terraformbucket"
    key = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# RETRIVES THE INFORMATION FROM THE REMOTE STATE FILE ALB
data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "state-terraformbucket"
    key = "alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# FETCHES THE INFORMATION OF LAB-AMI
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Ami-with-Ansible-Installed"
  owners           = ["self"]
}