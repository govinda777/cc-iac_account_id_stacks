data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block     = var.vpc_cidr_block
  vpc_name       = var.vpc_name
  public_subnets = var.public_subnets
}

module "ec2" {
    source = "./modules/ec2"

    ami                = data.aws_ami.latest_amazon_linux.id
    instance_type      = var.ec2_instance_type
    subnet_id          = module.vpc.public_subnet_ids[0]
    key_name           = var.ec2_key_name
    security_group_ids = [module.vpc.default_security_group_id]
    instance_name      = var.ec2_instance_name
    volume_size        = var.ec2_volume_size
    volume_type        = var.ec2_volume_type
    availability_zone  = var.ec2_availability_zone
}
