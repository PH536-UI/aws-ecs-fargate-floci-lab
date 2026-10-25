# Sanitized evidence: local ECS deployment

[🇧🇷 Português](../../evidence/local-ecs-deployment-2026-10-25.md) | 🇺🇸 English

- Execution date: October 25, 2026.
- Environment: Linux/WSL, Docker Desktop, and local Floci.
- Emulator endpoint: `http://localhost:4566`.
- Emulated account/region: `000000000000` / `us-east-1`.

## Result returned by emulated ECS

| Field | Value |
| --- | --- |
| Service | `ph-ecs-fargate-lab-app` |
| State | `ACTIVE` |
| Cluster | `ph-ecs-fargate-lab-cluster` |
| Launch type | `FARGATE` |
| Desired tasks | `1` |
| Running tasks | `1` |
| Pending tasks | `0` |
| Rollout | `COMPLETED` |
| Event | `has reached a steady state` |

## Evidence boundary

This record proves the result of the local emulated flow. It does not prove deployment, performance, availability, cost, observability, or security controls in real AWS. No real credential is included in this file.
