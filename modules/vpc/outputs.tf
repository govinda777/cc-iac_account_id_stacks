output "vpc_id" {
  value       = aws_vpc.main.id
  description = "O ID da VPC criada."
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "Os IDs das subnets públicas criadas na VPC."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gw.id
  description = "O ID do Internet Gateway associado à VPC."
}
