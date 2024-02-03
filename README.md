# cc-iac_account_id_stacks
Repositório de exemplo de uma infra simples

│
├── account # account_id 843210383 (ex: arq cloud)
│   ├── namespace # Team name (ex: Core, Governance, Sec))
│   |   ├── stack # Stack name (ex: vpc, es2, cloudwatch)
│   │   │   │   ├── main.tf
│   │   ├── env # dev, prod, etc
│   │   │   ├── dev
│   │   │   │   ├── terragrunt.hcl
│
│   │   │   ├── prod
│   │   │   │   ├── terragrunt.hcl
│
│   │   ├── modules
│   │   │   ├── cloudwatch
│   │   │   │   ├── main.tf
│   │   │   │   ├── outputs.tf
│   │   │   │   ├── variables.tf
│
│   │   │   ├── es2
│   │   │   │   ├── main.tf
│   │   │   │   ├── outputs.tf
│   │   │   │   ├── variables.tf
│
│   │   │   ├── vpc
│   │   │   │   ├── main.tf
│   │   │   │   ├── outputs.tf
│   │   │   │   ├── variables.tf
│   │   │   ├── backend.tf # How to save TF State in S3 Bucket
│   │   │   │   ├── main.tf
│   │   │   │   ├── outputs.tf
│   │   │   │   ├── variables.tf

cc-iac_account_id_stacks/
│
├── main.tf           # Arquivo principal, conecta todos os módulos
├── variables.tf      # Define as variáveis usadas nos módulos
├── outputs.tf        # Define os outputs do projeto
├── terraform.tfvars  # Valores para as variáveis definidas em variables.tf
├── backend.tf        # Configuração do backend do Terraform (ex: S3 para estado)
│
├── modules/          # Módulos reutilizáveis
│   ├── ec2/          # Módulo para instâncias EC2
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── vpc/          # Módulo para VPC
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── environments/     # Configurações específicas do ambiente (dev, prod)
    ├── dev/
    │   ├── terraform.tfvars
    │   └── ...
    └── prod/
        ├── terraform.tfvars
        └── ...



me ajude a implementar uma lógica para formatar o nome dessa instancia.

variable "resource_name" {
  description = "Nome da instância EC2"

  
}

modulo:

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.resource_name
  }

  # Detalhes adicionais como volume de EBS, configurações de rede, etc., podem ser adicionados aqui
}

# Este bloco é opcional e pode ser usado para criar um volume de EBS adicional
resource "aws_ebs_volume" "extra_volume" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.volume_type

  tags = {
    Name = "${var.resource_name}-extra-volume"
  }
}

# Este bloco é opcional e anexa o volume de EBS adicional à instância EC2
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.example.id
  force_detach = true
}


gostaria que o nome fosse uma concatenação do diretório que o recurso está sendo criado.

Por exemplo, se eu estiver no diretório /account/namespace/stack[env]/resource_type, o recurso deverá ser criado com a concatenação dessa informação.

/account/namespace/stack[env]/resource_type

Ex:

module "my_ec2_instance" {
    source        = "../../../modules/ec2"
    resource_name = "my_ec2_instance"
}

Terá esse nome : account__namespace__stack__dev__resource_name__resource_type_

account: 843210383
namespace: core
stack: tool_abc
env: dev
resource_name: my_ec2_instance
resource_type: aws_instance

Nome:

843210383__core__tool_abc__dev__my_ec2_instance__aws_instance
