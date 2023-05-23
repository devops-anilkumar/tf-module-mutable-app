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

# RETRIVES THE INFORMATION FROM THE REMOTE STATE FILE DB
data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "state-terraformbucket"
    key = "databases/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# FETCHES THE INFORMATION OF LAB-AMI
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Ami-with-Ansible-Installed"
  owners           = ["self"]
}

#FETCHING THE SECRETS FROM SECRET MANNAGER
data "aws_secretsmanager_secret" "secrets" {
  name = "roboshop/secrets"
}


data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}