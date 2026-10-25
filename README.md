# AWS ECS Fargate Delivery Lab, com Floci

Laboratório de portfólio que empacota uma aplicação web em Docker, publica a imagem em um ECR **emulado** e a executa como tarefa/serviço ECS Fargate **emulado**. A infraestrutura é declarada em Terraform e validada no GitHub Actions.

> **Transparência:** este projeto usa [Floci](https://github.com/floci-io/floci) em Linux local. Ele emula APIs e comportamentos selecionados da AWS com Docker. Nenhuma conta AWS, recurso AWS real ou cobrança cloud é usada por este repositório. Isso não é uma implantação em produção na AWS.

## O que este laboratório demonstra
- Dockerização de uma aplicação HTTP mínima.
- Registro de imagem via API compatível com Amazon ECR.
- Recursos ECS, Fargate, rede e IAM declarados em Terraform.
- Pipeline de CI para sintaxe Python, build Docker e validação Terraform.
- Processo de deploy e limpeza reproduzível, com evidências locais.

## Arquitetura
```text
Aplicação Python -> Docker image -> ECR emulado (Floci)
                                  -> ECS cluster + task definition Fargate emulados
Terraform ----------------------> API local do Floci :4566
GitHub Actions -----------------> valida código e Terraform, sem fazer deploy
```

## Pré-requisitos no Linux/WSL
- Docker Desktop com integração WSL ativa, ou Docker Engine em Linux.
- Docker Compose v2.
- Terraform >= 1.6 no Linux/WSL.
- `curl` e Bash.

**AWS CLI no host não é necessário.** O Compose usa `floci/floci:latest-compat`, que traz a AWS CLI já configurada dentro do contêiner do emulador. Não há `aws configure`, credenciais AWS, token ou conta cloud neste fluxo.

```bash
cd ~/aws-ecs-fargate-floci-lab
chmod +x scripts/*.sh
./scripts/check-prerequisites.sh
```

> No Windows, abra uma distribuição Linux/WSL. Não rode os scripts no PowerShell. O Floci recebe o socket Docker para executar as tasks ECS emuladas como contêineres reais.

## Execução local
```bash
cd ~/aws-ecs-fargate-floci-lab
./scripts/deploy-local.sh
```

O provider usa apenas credenciais fictícias (`test`) e aponta explicitamente para `http://localhost:4566`. A AWS CLI, quando necessária pelo script para ECR/ECS, executa dentro do contêiner Floci.

## Limpeza obrigatória
```bash
cd ~/aws-ecs-fargate-floci-lab
./scripts/destroy-local.sh
docker compose down
```

## Limitações conhecidas
- Floci não é AWS e não equivale a disponibilidade, segurança, performance, permissões e cobrança de uma conta real.
- O GitHub Actions **não faz deploy**: runners hospedados não acessam Floci local e o projeto não armazena credenciais cloud.
- Antes de adaptar para AWS real, revise IAM, VPC, subnets, NAT/load balancer, logs, segredos, custos e controles de segurança. A configuração da AWS CLI será uma etapa deliberada dessa migração, não deste laboratório.

## Licença
MIT. Veja [LICENSE](LICENSE).
