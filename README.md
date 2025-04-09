# Terraform - AWS S3 Bucket com Boas Práticas

Projeto desenvolvido com Terraform para criação de um bucket S3 seguro, versionado, com políticas de ciclo de vida, criptografia, e bloqueio de acesso público.

## Objetivo

Este projeto tem como objetivo provisionar um bucket S3 na AWS aplicando as principais boas práticas recomendadas:

- Versionamento de objetos
- Criptografia em repouso (SSE-S3)
- Políticas de ciclo de vida:
  - Transição para S3 Glacier Instant Retrieval após 30 dias
  - Expiração de objetos após 31 dias
  - Exclusão de versões antigas após 1 dia
- Bloqueio de acesso público
- Política forçando acesso apenas via SSL (opcional)
- Tags para organização e gestão de custos

---

## Pré-requisitos

- Terraform >= 1.x
- AWS CLI configurado
- Conta AWS com permissões suficientes:
  - `AmazonS3FullAccess`
  - `IAMReadOnlyAccess` (caso utilize backend remoto)
  
---

## Estrutura do Projeto

