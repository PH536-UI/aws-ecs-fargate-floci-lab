# Local execution runbook

[🇧🇷 Português](../runbook.md) | 🇺🇸 English

## 1. Open Linux/WSL
On Windows, use a WSL distribution. Do not run these commands in PowerShell.

## 2. Clone the repository
```bash
git clone https://github.com/PH536-UI/aws-ecs-fargate-floci-lab.git
cd aws-ecs-fargate-floci-lab
chmod +x scripts/*.sh
```

## 3. Prerequisites
You need the following in Linux/WSL:
- Docker Desktop with WSL integration enabled, or Docker Engine;
- Docker Compose v2;
- Terraform >= 1.6;
- Bash and `curl`.

The AWS CLI **does not need to be installed or configured on the host**. The project starts `floci/floci:latest-compat`; that image includes an AWS CLI preconfigured for the emulator itself. Do not run `aws configure`, provide keys, or connect an AWS account.

```bash
./scripts/check-prerequisites.sh
```

## 4. Deploy locally
```bash
./scripts/deploy-local.sh
```

The script, in this order:
1. starts Floci at `http://localhost:4566`;
2. applies the Terraform foundation to the local endpoint;
3. runs AWS CLI only inside the Floci container to get emulated ECR login;
4. builds and pushes the Docker image to the local registry;
5. creates the emulated ECS/Fargate task and service;
6. displays the final service state.

Floci receives the WSL Docker socket because its emulated ECS tasks are real Docker containers. This remains local and creates no AWS resources.

## 5. Check state without AWS CLI on the host
```bash
docker compose exec -T floci aws ecs list-clusters
docker compose exec -T floci aws ecs list-services --cluster ph-ecs-fargate-lab-cluster
docker compose exec -T floci aws ecr describe-repositories
```

## 6. Clean up
```bash
./scripts/destroy-local.sh
docker compose down
```

## Common failures
| Symptom | Safe check |
|---|---|
| Docker does not start | Open Docker Desktop and enable WSL integration for your distribution. |
| Floci does not become healthy | Run `docker compose logs floci`. |
| Docker socket error | Confirm `docker info` in WSL before deployment. |
| Terraform attempts real AWS | Stop and confirm `http://localhost:4566` in the provider and command. |
| Registry rejects a push | Check the URI returned by emulated ECR and `docker compose logs floci`. |
