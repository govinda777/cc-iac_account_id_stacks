variable "cidr_block" {
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
