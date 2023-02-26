//Configure the AWS Provider
# terraform {

#   backend "s3" {
#     bucket = "myapp-bucket"
#     key    = "myapp/state.tfstate"
#     region = ""
#   }
# }

provider "aws" {
  region = "us-east-1"
}

//use tf default vpc module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs            = [var.avail_zone]
  public_subnets = [var.subnet_cidr_block]
  public_subnet_tags = {
    Name = "${var.env_prefix}-subnet-1"
  }

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}



module "myapp-server" {
  source              = "./modules/webserver"
  vpc_id              = module.vpc.vpc_id
  my_ip               = var.my_ip
  env_prefix          = var.env_prefix
  image_name          = var.image_name
  public_key_location = var.public_key_location
  instance_type       = var.instance_type
  subnet_id           = module.vpc.public_subnets[0]
  avail_zone          = var.avail_zone

}

//define firewall rules with a security group, associate it with my vpc
# resource "aws_security_group" "myapp-sg" {
#   name   = "myapp-sg"
#   vpc_id = aws_vpc.myapp_vpc.id

#   ingress {
#     description = "value"
#     //port range
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [var.my_ip]
#   }

#   ingress {
#     description = "value"
#     //port range
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#     prefix_list_ids = []
#   }

#   tags = {
#     Name = "${var.env_prefix}-sg"
#   }
# }

