variable "cidr_block" {
  description = "O bloco CIDR para a VPC."
  type        = string
  default     = "10.0.0.0/26" # 64 ips
}

variable "vpc_name" {
  description = "O nome da VPC."
  type        = string
  default     = "vpc"
}

variable "public_subnets" {
  description = "Uma lista de blocos CIDR para as subnets públicas."
  type        = list(string)
}
