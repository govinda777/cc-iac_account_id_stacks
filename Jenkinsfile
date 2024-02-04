pipeline {
    agent any

    stages {
        stage('Download Artifact') {
            steps {
                // Comandos para baixar artefatos
            }
        }
        stage('Get Plan to the TF CONTROLLER') {
            steps {
                // Comandos para gerar plano Terraform
            }
        }
        stage('Save Plan in Repo') {
            steps {
                // Comandos para salvar o plano no repositório
            }
        }
        stage('Execute Policie') {
            steps {
                // Comandos para executar políticas
            }
        }
        stage('Execute Sync Terraform in Cloud AWS') {
            steps {
                // Comandos para aplicar mudanças na AWS
            }
        }
        stage('Save tfstate in S3') {
            steps {
                // Comandos para salvar o estado no S3
            }
        }
    }
}
