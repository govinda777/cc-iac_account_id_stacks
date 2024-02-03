# cc-iac_account_id_stacks

## Resumo

Este repositório contém a infraestrutura como código (IaC) para a configuração e gerenciamento de recursos na nuvem. Utiliza Terraform e Terragrunt para orquestrar e modularizar a infraestrutura de forma eficiente e escalável.

## Objetivo
O principal objetivo deste projeto é fornecer uma estrutura clara e reutilizável para a criação e gerenciamento de recursos na nuvem, garantindo a consistência e a facilidade de manutenção em diferentes ambientes (desenvolvimento, teste, produção).

## Arquitetura

A arquitetura do projeto é baseada em módulos Terraform, que são usados para definir e configurar recursos de nuvem específicos como EC2, VPC e CloudWatch. Cada módulo é projetado para ser reutilizável e configurável para diferentes ambientes.

```
iac__account_id_namespace_stacks_env
│
├── LICENSE                    # License file for the project
├── README.md                  # README file with project description and instructions
├── how_to_create_module.md    # Guide on how to create a module in this setup
├── terragrunt.hcl             # Terragrunt configuration file
│
└── account                    # Main directory for account configurations
    ├── backend.tf             # Terraform backend configuration
    ├── main.tf                # Main Terraform configuration file
    ├── outputs.tf             # Terraform outputs file
    ├── variables.tf           # Terraform variables file
    │
    └── namespace              # Namespace directory for organizing (Core , Governance, Tools departaments)resources
        ├── modules            # Modules directory containing reusable components
        │   ├── cloudwatch     # CloudWatch module
        │   │   ├── main.tf    # Main file for CloudWatch module
        │   │   ├── outputs.tf # Outputs for CloudWatch module
        │   │   └── variables.tf# Variables for CloudWatch module
        │   │
        │   ├── ec2            # EC2 module
        │   │   ├── main.tf    # Main file for EC2 module
        │   │   ├── outputs.tf # Outputs for EC2 module
        │   │   └── variables.tf# Variables for EC2 module
        │   │
        │   └── vpc            # VPC module
        │       ├── main.tf    # Main file for VPC module
        │       ├── outputs.tf # Outputs for VPC module
        │       └── variables.tf# Variables for VPC module
        │
        └── stack              # Stack directory for specific environment 
            ├── env           # Environment-specific configurations
            │   ├── dev       # Development environment
            │   │   └── terragrunt.hcl # Terragrunt config for d
            │   ├── prod      # Production environment
            │   │   └── terragrunt.hcl # Terragrunt config for production 
            │   └── test      # Test environment
            │       └── terragrunt.hcl # Terragrunt config for test 
            │
            ├── main.tf       # Main file for stack configurations
            ├── outputs.tf    # Outputs for stack configurations
            └── variables.tf  # Variables for stack configurations
```

This structure shows a clear separation of concerns and modular design, typical in infrastructure as code (IaC) projects using Terraform and Terragrunt. The `modules` directory contains reusable definitions for various AWS services, while the `env` directory under `stack` allows for environment-specific configurations (development, production, test), each with its own Terragrunt configuration.


## Como configurar o backend.tf

Para configurar o `backend.tf`, siga estas etapas:
1. Defina o bucket S3 onde o estado do Terraform será armazenado.
2. Configure a região e os detalhes de acesso.
3. Especifique o bloqueio de estado usando DynamoDB para evitar conflitos de estado.

Exemplo de configuração:
```hcl
terraform {
  backend "s3" {
    bucket         = "<bucket-name>"
    key            = "<path-to-state-file>"
    region         = "<region>"
    dynamodb_table = "<dynamodb-lock-table>"
    encrypt        = true
  }
}
```

## Veja como um recurso é criado

### Padronização de nomenclatura
Para garantir a consistência e evitar conflitos, os recursos são nomeados seguindo um padrão definido. O padrão de nomenclatura é configurado da seguinte maneira:

```hcl
inputs = {
  resource_name = format("%s__%s__%s__%s__%s__%s", 
    inputs.account, 
    inputs.namespace, 
    inputs.stack, 
    inputs.env, 
    inputs.resource_name, 
    inputs.resource_type
  )
}
```

## Env variables

$AWS_ACCESS_KEY_ID
$AWS_SECRET_ACCESS_KEY
$AWS_DEFAULT_REGION
$ACCOUNT
$NAMESPACE
$STACK
$ENV


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
