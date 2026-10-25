# Architecture decisions

[🇧🇷 Português](../architecture.md) | 🇺🇸 English

## Goal
Practice the container delivery lifecycle, from code and image to registry, infrastructure as code, and container orchestration, without depending on a real cloud account.

## Components
| Component | Role | Execution |
|---|---|---|
| `app/server.py` | HTTP `/health` endpoint | Docker container |
| ECR | image storage | emulated by Floci |
| ECS cluster | logical workload grouping | emulated by Floci |
| Task definition | CPU, memory, networking, and image | Terraform, Fargate-compatible |
| ECS service | maintains one desired replica | emulated by Floci |
| GitHub Actions | validates repository quality | GitHub runner, no deployment |

## Intentional choices
- **Fargate:** task definition with `awsvpc`, `cpu = 256`, and `memory = 512`.
- **Minimal image:** standard Python with `python:3.12-alpine`.
- **Two-phase deployment:** create ECR first, then push the image and create the service.
- **Credential-free CI:** validation runs on GitHub; deployment runs on the computer hosting Floci.
- **Explicit local IaC:** a local endpoint and fictional credentials avoid real AWS.

## Success criteria
`terraform apply` completes both phases, the image appears in local ECR, and `ecs describe-services` returns the local service.
