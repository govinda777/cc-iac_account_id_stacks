variable "aws_region" {
  description = "Região da AWS para lançar recursos"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "O bloco CIDR para a VPC."
  type        = string
}

variable "vpc_name" {
  description = "O nome da VPC."
  type        = string
}

variable "public_subnets" {
  description = "Uma lista de blocos CIDR para as subnets públicas."
  type        = list(string)
}

variable "ec2_ami" {
  description = "AMI a ser usada para a instância EC2"
  type        = string
}

variable "ec2_instance_type" {
  description = "Tipo de instância EC2"
  type        = string
}

variable "ec2_key_name" {
  description = "Nome da chave SSH para acesso à instância"
  type        = string
}

variable "ec2_instance_name" {
  description = "Nome da instância EC2"
  type        = string
}

variable "ec2_volume_size" {
  description = "Tamanho do volume EBS (em GiB)"
  type        = number
}

variable "ec2_volume_type" {
description = "Tipo do volume EBS"
  type        = string
}

variable "ec2_availability_zone"{
    description = "Zona de disponibilidade para o volume EBS"
    type        = string
}
    
    variable "ec2_security_group_ids" {
        description = "IDs dos grupos de segurança associados à instância"
        type        = list(string)
}