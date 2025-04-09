# Define o provedor AWS e a região onde os recursos serão criados
provider "aws" {
  region = "us-east-1"  # Região Norte da Virgínia (padrão do laboratório)
}

# Criação do bucket S3
resource "aws_s3_bucket" "lab_bucket" {
  bucket = "bkt-caionunes21314234"  # Nome do bucket - deve ser único globalmente
  acl    = "private"               # Controle de acesso - privado por padrão (boa prática)

  # Habilitação do versionamento no bucket
  versioning {
    enabled = true  # Ativa o versionamento para armazenar múltiplas versões dos arquivos
  }

  # Configuração da regra de ciclo de vida (automatiza movimentação e expiração dos dados)
  lifecycle_rule {
    id      = "MoverParaGlacierApos30Dias"  # Nome identificador da regra
    enabled = true  # Ativa a regra de ciclo de vida

    # Transição de arquivos para o S3 Glacier Instant Retrieval após 30 dias
    transition {
      days          = 30                   # Dias após criação do objeto
      storage_class = "GLACIER_IR"         # Classe de armazenamento econômico
    }

    # Expiração dos arquivos após 31 dias
    expiration {
      days = 31  # Apaga a versão atual após 31 dias
    }

    # Expiração das versões antigas após 1 dia
    noncurrent_version_expiration {
      days = 1  # Apaga versões não atuais após 1 dia
    }
  }

  # Criptografia do lado do servidor com chaves gerenciadas da AWS (SSE-S3)
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"  # Algoritmo padrão de criptografia
      }
    }
  }

  # Tags opcionais (identificação do recurso)
  tags = {
    Name        = "Laboratório S3"  # Nome descritivo do recurso
    Environment = "Lab"             # Ambiente de laboratório
  }
}

# Bloqueio de acesso público (boa prática de segurança)
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.lab_bucket.id

  block_public_acls       = true  # Bloqueia ACLs públicas
  block_public_policy     = true  # Bloqueia políticas públicas
  ignore_public_acls      = true  # Ignora ACLs públicas se existirem
  restrict_public_buckets = true  # Restringe acesso público ao bucket
}

# Exibe o nome do bucket após a execução do Terraform (output)
output "bucket_name" {
  value = aws_s3_bucket.lab_bucket.id  # Mostra o nome do bucket criado
}

#######################################################################################
# Observação sobre URLs Pré-assinadas:
# Terraform não gera URLs pré-assinadas diretamente (por segurança).
# O recomendado é usar AWS CLI ou SDK para isso.
#
# Exemplo de comando AWS CLI após criar o bucket e subir o arquivo Lab3.txt:
# aws s3 presign s3://seu-nome-bucket-lab3/Lab3.txt --expires-in 60
#
# Este comando gera uma URL temporária com validade de 60 segundos.
#######################################################################################
