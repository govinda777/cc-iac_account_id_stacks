

variable "aws_region" {
  description = "Região da AWS para lançar recursos"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr_block" {
  description = "O bloco CIDR para a VPC."
  type        = string
  default     = "10.0.0.0/26" # 50 ips
}

variable "public_subnets" {
  description = "Uma lista de blocos CIDR para as subnets públicas."
  type        = list(string)
  default     = ["10.0.0.0/28", "10.0.0.16/28", "10.0.0.32/28", "10.0.0.48/28"]
}

variable "vpc_name" {
  description = "O nome da VPC."
  type        = string
  default = "vpc-terraform-ec2"
}

variable "ec2_instance_type" {
  description = "Tipo de instância EC2"
  type        = string
  default     = "t3.small"
}

variable "ec2_instance_name" {
  description = "Nome da instância EC2"
  type        = string
  default     = "my-ec2-instance"
}