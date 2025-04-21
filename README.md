# ☁️ Provisionamento de Bucket S3 com Terraform

## 📄 Descrição

Este projeto utiliza o Terraform para provisionar um bucket Amazon S3 com **boas práticas de segurança e gerenciamento de dados**, incluindo:

- Criptografia no lado do servidor
- Controle de acesso privado
- Versionamento de objetos
- Regras de ciclo de vida (expiração e transição para Glacier)
- Bloqueio de acesso público

## 📍 Região

Todos os recursos são criados na região:

- `us-east-1` (Norte da Virgínia)

## 🔐 Recursos Criados

### ✅ Bucket S3

- **Nome:** `bkt-caionunes21314234` *(editável - deve ser único globalmente)*
- **Acesso:** Privado (`private`)
- **Criptografia:** `AES256` (SSE-S3)
- **Versionamento:** Habilitado
- **Regras de ciclo de vida:**
  - Transição para *Glacier Instant Retrieval* após **30 dias**
  - Expiração da **versão atual** após **31 dias**
  - Expiração de **versões antigas** após **1 dia**

### 🚫 Bloqueio de Acesso Público

Configuração para garantir que o bucket **não possa ser tornado público**, mesmo que políticas tentem:

```hcl
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
