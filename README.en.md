# AWS ECS Fargate Delivery Lab, with Floci

[🇧🇷 Português](README.md) | 🇺🇸 English

A portfolio lab that packages a web application with Docker, publishes its image to an **emulated** ECR registry, and runs it as an **emulated** ECS Fargate task and service. Infrastructure is declared with Terraform and validated by GitHub Actions.

> **Transparency:** this project uses [Floci](https://github.com/floci-io/floci) on local Linux. It emulates selected AWS APIs and behaviours with Docker. No AWS account, real AWS resource, or cloud charge is used by this repository. This is not a production deployment on AWS.

## Verified local result

On October 25, 2026, the local flow was executed and the emulated ECS response confirmed:

- `ph-ecs-fargate-lab-app` service in `ACTIVE` state.
- `desiredCount: 1`, `runningCount: 1`, and `pendingCount: 0`.
- `FARGATE` launch type on Linux.
- Primary deployment with `rolloutState: COMPLETED`.
- Service event: `has reached a steady state`.

The sanitized evidence is available at [docs/en/evidence/local-ecs-deployment-2026-10-25.md](docs/en/evidence/local-ecs-deployment-2026-10-25.md). This validates the local Floci flow, not an execution in a real AWS account.

## What this lab demonstrates
- Dockerizing a minimal HTTP application.
- Image registry flow through an Amazon ECR-compatible API.
- ECS, Fargate, network, and IAM resources declared with Terraform.
- A CI pipeline for Python syntax, Docker build, and Terraform validation.
- A reproducible local deployment and cleanup process with evidence.

## Architecture
```text
Python application -> Docker image -> Emulated ECR (Floci)
                                    -> Emulated ECS cluster + Fargate task definition
Terraform ------------------------> Local Floci API :4566
GitHub Actions -------------------> Validates code and Terraform, without deploying
```

## Linux/WSL prerequisites
- Docker Desktop with WSL integration enabled, or Docker Engine on Linux.
- Docker Compose v2.
- Terraform >= 1.6 on Linux/WSL.
- `curl` and Bash.

**The AWS CLI is not required on the host.** Compose uses `floci/floci:latest-compat`, which includes an AWS CLI preconfigured for the emulator container itself. There is no `aws configure`, AWS credential, token, or cloud account in this flow.

```bash
cd ~/aws-ecs-fargate-floci-lab
chmod +x scripts/*.sh
./scripts/check-prerequisites.sh
```

> On Windows, open a Linux/WSL distribution. Do not run the scripts in PowerShell. Floci receives the Docker socket so it can execute emulated ECS tasks as real Docker containers.

## Local execution
```bash
cd ~/aws-ecs-fargate-floci-lab
./scripts/deploy-local.sh
```

The provider uses only fictional `test` credentials and explicitly targets `http://localhost:4566`. When the script needs AWS CLI commands for ECR or ECS, they run only inside the Floci container.

## Required cleanup
```bash
cd ~/aws-ecs-fargate-floci-lab
./scripts/destroy-local.sh
docker compose down
```

## Known limitations
- Floci is not AWS and does not represent the availability, security, performance, permissions, or billing of a real account.
- GitHub Actions **does not deploy**: hosted runners cannot reach a local Floci instance, and the project stores no cloud credentials.
- Before adapting this project to real AWS, review IAM, VPC, subnets, NAT/load balancer, logging, secrets, costs, and security controls. AWS CLI configuration is a deliberate future migration step, not part of this lab.

## Documentation
- [Architecture decisions](docs/en/architecture.md)
- [Costs and safety](docs/en/cost-and-safety.md)
- [Local runbook](docs/en/runbook.md)
- [Portfolio summary](docs/en/portfolio-summary.md)

## License
MIT. See [LICENSE](LICENSE).
