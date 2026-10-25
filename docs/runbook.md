# Runbook de execução local

## 1. Abrir Linux/WSL
No Windows, use a distribuição WSL. Não rode estes comandos no PowerShell.

## 2. Clonar o repositório
```bash
git clone https://github.com/PH536-UI/aws-ecs-fargate-floci-lab.git
cd aws-ecs-fargate-floci-lab
chmod +x scripts/*.sh
```

## 3. Pré-requisitos
Você precisa ter no Linux/WSL:
- Docker Desktop com integração WSL ativa, ou Docker Engine;
- Docker Compose v2;
- Terraform >= 1.6;
- Bash e `curl`.

A AWS CLI **não precisa estar instalada nem configurada no host**. O projeto sobe `floci/floci:latest-compat`; essa imagem traz a AWS CLI pré-configurada para o próprio emulador. Não use `aws configure`, não informe chaves e não conecte uma conta AWS.

```bash
./scripts/check-prerequisites.sh
```

## 4. Implantar localmente
```bash
./scripts/deploy-local.sh
```

O script faz, nesta ordem:
1. inicia o Floci em `http://localhost:4566`;
2. aplica a fundação Terraform no endpoint local;
3. executa a AWS CLI apenas dentro do contêiner Floci para obter o login ECR emulado;
4. constrói e envia a imagem Docker ao registry local;
5. cria a task e o service ECS/Fargate emulados;
6. exibe o estado final do service.

O Floci recebe o socket Docker do WSL, pois suas tasks ECS emuladas são contêineres Docker reais. Isso continua local: não cria recursos em AWS.

## 5. Verificar estado sem AWS CLI no host
```bash
docker compose exec -T floci aws ecs list-clusters
docker compose exec -T floci aws ecs list-services --cluster ph-ecs-fargate-lab-cluster
docker compose exec -T floci aws ecr describe-repositories
```

## 6. Limpar ambiente
```bash
./scripts/destroy-local.sh
docker compose down
```

## Falhas comuns
| Sintoma | Verificação segura |
|---|---|
| Docker não inicia | Abra Docker Desktop e habilite a integração WSL para sua distribuição. |
| Floci não fica saudável | Rode `docker compose logs floci`. |
| Erro de Docker socket | Confirme `docker info` no WSL antes do deploy. |
| Terraform tenta AWS real | Pare e confirme `http://localhost:4566` no provider e no comando. |
| Registry não aceita push | Confira a URI retornada pelo ECR emulado e a saída de `docker compose logs floci`. |
