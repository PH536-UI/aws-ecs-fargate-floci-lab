# Portfolio summary

[🇧🇷 Português](../portfolio-summary.md) | 🇺🇸 English

## Context
I built a local delivery lab for a containerized application to practice the flow connecting development, registry, infrastructure as code, and container orchestration.

## Implementation
- Minimal Python HTTP application packaged with Docker.
- ECR, ECS, Fargate, VPC, subnet, security group, IAM, and logs described with Terraform.
- AWS APIs emulated locally with Floci.
- GitHub Actions CI validating syntax, Docker build, and Terraform.
- Runbook for execution, cleanup, and sanitized evidence.

## Demonstrable result
The local deployment was completed in Floci on October 25, 2026. The `ph-ecs-fargate-lab-app` service was confirmed as `ACTIVE`, with one emulated Fargate task running (`desiredCount: 1`, `runningCount: 1`, `pendingCount: 0`) and a `COMPLETED` rollout. The output also recorded that the service reached a steady state.

Evidence: [local-ecs-deployment-2026-10-25.md](evidence/local-ecs-deployment-2026-10-25.md).

## How to present it in an interview
> I developed a local ECS Fargate delivery lab. I containerized a Python application, modeled ECR, ECS, networking, IAM, and logging with Terraform, and implemented validation in GitHub Actions. To avoid costs and dependency on an AWS account, I executed the flow in Floci, a local emulator compatible with selected AWS APIs. I validated an emulated service in steady state with one task running. I explicitly document that this demonstrates a local technical flow, not a production deployment on AWS.

## What this project does not claim
No AWS resources, costs, or production deployment were involved. Floci is a local emulator useful for practicing interfaces and flows, but it does not reproduce all operational guarantees of AWS.

## Skills demonstrated
Docker, Terraform, AWS ECS/ECR/Fargate, GitHub Actions, technical documentation, security principles, and cost management.
