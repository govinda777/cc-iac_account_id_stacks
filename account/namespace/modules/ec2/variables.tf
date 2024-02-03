
variable "instance_type" {
  description = "Tipo de instância EC2"

    validation {
    condition     = contains(["t2.micro", "t2.small", "t3.micro", "t3.small"], var.instance_type)
    error_message = "O tipo de instância deve ser t2.micro, t2.small, t3.micro ou t3.small."
  }
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

variable "resource_name" {
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
