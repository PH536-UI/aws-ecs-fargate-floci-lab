# Runbook de execução local

## 1. Abrir Linux/WSL
No Windows, use a distribuição WSL. Não rode estes comandos no PowerShell.

## 2. Clonar o repositório
```bash
git clone https://github.com/PH536-UI/aws-ecs-fargate-floci-lab.git
cd aws-ecs-fargate-floci-lab
chmod +x scripts/*.sh
```

## 3. Checar ferramentas
```bash
./scripts/check-prerequisites.sh
```

## 4. Implantar localmente
```bash
./scripts/deploy-local.sh
```

A API compatível é local: `http://localhost:4566`; não há uso de credenciais AWS.

## 5. Verificar estado
```bash
aws --endpoint-url http://localhost:4566 --region us-east-1 ecs list-clusters
aws --endpoint-url http://localhost:4566 --region us-east-1 ecs list-services --cluster ph-ecs-fargate-lab-cluster
aws --endpoint-url http://localhost:4566 --region us-east-1 ecr describe-repositories
```

## 6. Limpar ambiente
```bash
./scripts/destroy-local.sh
docker compose down
```

## Falhas comuns
| Sintoma | Verificação segura |
|---|---|
| Ferramenta ausente | Instale no Linux/WSL e reabra o terminal. |
| Docker não inicia | Abra Docker Desktop e habilite a integração WSL. |
| Floci não fica saudável | Rode `docker compose logs floci`. |
| Terraform tenta AWS real | Pare e confirme `http://localhost:4566`. |
