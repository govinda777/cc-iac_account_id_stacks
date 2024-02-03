output "instance_id" {
  value       = aws_instance.example.id
  description = "O ID da instância EC2 criada."
}

output "instance_arn" {
  value       = aws_instance.example.arn
  description = "O ARN da instância EC2 criada."
}

output "instance_public_ip" {
  value       = aws_instance.example.public_ip
  description = "O endereço IP público da instância EC2."
}

output "instance_private_ip" {
  value       = aws_instance.example.private_ip
  description = "O endereço IP privado da instância EC2."
}

# Se você estiver criando um volume EBS adicional, você também pode querer exportar seu ID
output "extra_volume_id" {
  value       = aws_ebs_volume.extra_volume.id
  description = "O ID do volume EBS adicional criado."
}
