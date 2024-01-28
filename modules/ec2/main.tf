resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.instance_name
  }

  # Detalhes adicionais como volume de EBS, configurações de rede, etc., podem ser adicionados aqui
}

# Este bloco é opcional e pode ser usado para criar um volume de EBS adicional
resource "aws_ebs_volume" "extra_volume" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.volume_type

  tags = {
    Name = "${var.instance_name}-extra-volume"
  }
}

# Este bloco é opcional e anexa o volume de EBS adicional à instância EC2
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.example.id
  force_detach = true
}
