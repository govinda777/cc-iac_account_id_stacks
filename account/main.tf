provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../modules/vpc"
  vpc_name       = var.account
}

module "ec2" {
    source = "./modules/ec2"

    ami                = data.aws_ami.latest_amazon_linux.id
    instance_type      = var.ec2_instance_type
    key_name           = var.ec2_key_name
    security_group_ids = [module.vpc.default_security_group_id]
    instance_name      = var.ec2_instance_name
}
