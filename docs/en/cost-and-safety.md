# Costs and safety

[🇧🇷 Português](../cost-and-safety.md) | 🇺🇸 English

## Lab cost
The default design creates no AWS resources. Floci, Docker, and Terraform run locally, so this execution has no AWS charge.

## Why the distinction matters
In real AWS, ECS on Fargate charges for CPU and memory while a task runs. EKS also has a per-cluster charge in addition to worker nodes. This repository must not be presented as proof of AWS costs or production operation.

## Safety rules
1. Never change `floci_endpoint` to an AWS account without a manual review.
2. Never commit keys, tokens, `.env` files, or Terraform state files.
3. Use demonstration data only in the application and evidence.
4. Run `destroy-local.sh` after tests.
5. Review the Terraform plan before adapting it to real cloud infrastructure.
