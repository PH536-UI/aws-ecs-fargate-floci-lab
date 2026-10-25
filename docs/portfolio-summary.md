# Resumo para portfólio

## Contexto
Construí um laboratório local de entrega de aplicação conteinerizada para praticar o fluxo que conecta desenvolvimento, registry, infraestrutura como código e orquestração de contêineres.

## Implementação
- Aplicação HTTP mínima em Python, empacotada em Docker.
- ECR, ECS, Fargate, VPC, subnet, security group, IAM e logs descritos com Terraform.
- APIs AWS emuladas localmente com Floci.
- CI no GitHub Actions validando sintaxe, build Docker e Terraform.
- Runbook de execução, limpeza e evidências sanitizadas.

## Resultado demonstrável
O deploy local foi concluído no Floci em 25 de outubro de 2026. O serviço `ph-ecs-fargate-lab-app` foi confirmado como `ACTIVE`, com uma task Fargate emulada em execução (`desiredCount: 1`, `runningCount: 1`, `pendingCount: 0`) e rollout `COMPLETED`. A saída também registrou que o serviço atingiu estado estável.

Evidência: [local-ecs-deployment-2026-10-25.md](evidence/local-ecs-deployment-2026-10-25.md).

## Como apresentar em uma entrevista
> Desenvolvi um laboratório local de entrega para ECS Fargate. Containerizei uma aplicação Python, modelei ECR, ECS, rede, IAM e logs com Terraform e implementei validações no GitHub Actions. Para evitar custos e depender de uma conta AWS, executei o fluxo em Floci, um emulador local compatível com APIs AWS selecionadas. Validei um serviço emulado em estado estável, com uma task em execução. Eu deixo explícito que isso demonstra o fluxo técnico local, não uma implantação de produção na AWS.

## O que este projeto não afirma
Não houve recursos, custos ou implantação produtiva em AWS. Floci é um emulador local, útil para praticar interfaces e fluxos, mas não replica todas as garantias operacionais da AWS.

## Competências demonstradas
Docker, Terraform, AWS ECS/ECR/Fargate, GitHub Actions, documentação técnica, princípios de segurança e gestão de custos.
