variable "aws_region" {
  description = "Região da AWS para lançar recursos"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "O bloco CIDR para a VPC."
  type        = string
  default     = "10.0.0.0/26"
}

variable "vpc_name" {
  description = "O nome da VPC."
  type        = string
  default     = "vpc_toolsABC"
}

variable "ec2_instance_name" {
  description = "Nome da instância EC2"
  type        = string
}