# cc-iac_account_id_stacks
Repositório de exemplo de uma infra simples


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
