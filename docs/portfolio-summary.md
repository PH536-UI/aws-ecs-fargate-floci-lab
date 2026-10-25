# Resumo para portfólio

## Contexto
Construí um laboratório local de entrega de aplicação conteinerizada para praticar o fluxo que conecta desenvolvimento, registry, infraestrutura como código e orquestração de contêineres.

## Implementação
- Aplicação HTTP mínima em Python, empacotada em Docker.
- ECR, ECS, Fargate, VPC, subnet, security group, IAM e logs descritos com Terraform.
- APIs AWS emuladas localmente com Floci.
- CI no GitHub Actions validando sintaxe, build Docker e Terraform.
- Runbook de execução, limpeza e evidências sanitizadas.

## O que este projeto não afirma
Não houve recursos, custos ou implantação produtiva em AWS. Floci é um emulador local, útil para praticar interfaces e fluxos, mas não replica todas as garantias operacionais da AWS.

## Competências demonstradas
Docker, Terraform, AWS ECS/ECR/Fargate, GitHub Actions, documentação técnica, princípios de segurança e gestão de custos.
