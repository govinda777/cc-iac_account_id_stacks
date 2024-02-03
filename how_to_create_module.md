Claro, vou guiá-lo passo a passo sobre como criar um módulo no Terraform e como usar um recurso criado através desse módulo. Vamos criar um módulo para uma instância EC2 na AWS e depois usá-lo para criar efetivamente uma instância EC2 em nosso projeto Terraform.

### Tutorial: Criar e Utilizar um Módulo Terraform

#### Passo 1: Criar o Módulo

1. **Estrutura do Módulo**: Primeiro, crie uma pasta para o seu módulo. Dentro dessa pasta, você terá arquivos para a definição do recurso (`main.tf`), variáveis (`variables.tf`) e saídas (`outputs.tf`).

   Estrutura de diretório sugerida:
    ```
    terraform-project/
    ├── modules/
    │   └── ec2_instance/
    │       ├── main.tf
    │       ├── variables.tf
    │       └── outputs.tf
    └── main.tf
    ```

2. **Definindo o Recurso (`main.tf`)**: Aqui, você vai definir o recurso da instância EC2. 

    **modules/ec2_instance/main.tf**:
    ```hcl
    resource "aws_instance" "example" {
      ami           = var.ami_id
      instance_type = var.instance_type

      tags = {
        Name = var.instance_name
      }
    }
    ```

3. **Variáveis do Módulo (`variables.tf`)**: Defina as variáveis que seu módulo precisa.

    **modules/ec2_instance/variables.tf**:
    ```hcl
    variable "ami_id" {
      description = "AMI ID para a instância."
      type        = string
    }

    variable "instance_type" {
      description = "Tipo da instância."
      type        = string
      default     = "t2.micro"
    }

    variable "instance_name" {
      description = "Nome da instância."
      type        = string
      default     = "ExampleInstance"
    }
    ```

4. **Saídas do Módulo (`outputs.tf`)**: Defina saídas para expor informações sobre os recursos criados, como o ID da instância.

    **modules/ec2_instance/outputs.tf**:
    ```hcl
    output "instance_id" {
      value = aws_instance.example.id
    }
    ```

#### Passo 2: Utilizar o Módulo no Projeto Terraform

1. **Configurar o Provedor**: No seu arquivo `main.tf` na raiz do projeto Terraform, configure o provedor AWS.

   **main.tf**:
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }
   ```

2. **Chamar o Módulo**: Use o módulo `ec2_instance` para criar uma instância EC2, passando os parâmetros necessários.

   **main.tf**:
   ```hcl
   module "my_ec2_instance" {
     source        = "./modules/ec2_instance"
     ami_id        = "ami-12345678"  # Substitua com uma AMI válida
     instance_name = "MinhaInstanciaEC2"
   }
   ```

3. **Referenciar o Módulo em Outro Recurso**: Se você quiser usar a saída do módulo em outro recurso, use a referência do módulo. Por exemplo, vamos criar um Security Group que se refere à instância EC2.

   **main.tf**:
   ```hcl
   resource "aws_security_group" "example_sg" {
     name = "example_security_group"

     ingress {
       from_port = 22
       to_port   = 22
       protocol  = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }

     tags = {
       InstanceID = module.my_ec2_instance.instance_id
     }
   }
   ```

#### Passo 3: Executando o Terraform

1. **Inicialização do Terraform**: No diretório raiz do seu projeto, execute `terraform init` para inicializar o Terraform e baixar os provedores necessários.

2. **Planejamento**: Execute `terraform plan` para revisar as mudanças que serão aplicadas.

3. **Aplicação**: Execute `terraform apply` para criar os recursos definidos.

### Conclusão

Este tutorial demonstrou como criar um módulo Terraform para gerenciar instâncias EC2 e como usar este módulo em um projeto Terraform. Os módulos são uma excelente maneira de reutilizar