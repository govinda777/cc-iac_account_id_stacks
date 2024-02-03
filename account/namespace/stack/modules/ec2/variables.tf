variable "ami" {
  description = "AMI a ser usada para a instância EC2"
}

variable "instance_type" {
  description = "Tipo de instância EC2"
}

variable "subnet_id" {
  description = "ID da subnet onde a instância será criada"
}

variable "key_name" {
  description = "Nome da chave SSH para acesso à instância"
}

variable "security_group_ids" {
  description = "IDs dos grupos de segurança associados à instância"
  type        = list(string)
}

variable "instance_name" {
  description = "Nome da instância EC2"
}

# Variáveis para o volume EBS adicional
variable "availability_zone" {
  description = "Zona de disponibilidade para o volume EBS"
}

variable "volume_size" {
  description = "Tamanho do volume EBS (em GiB)"
}

variable "volume_type" {
  description = "Tipo do volume EBS"
}
