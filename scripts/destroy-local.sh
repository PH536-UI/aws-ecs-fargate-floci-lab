#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENDPOINT="${FLOCI_ENDPOINT:-http://localhost:4566}"

cd "$ROOT_DIR/infra"
terraform init
terraform destroy -auto-approve -var="floci_endpoint=$ENDPOINT" -var="deploy_application=true"
printf "Terraform-managed lab resources removed. To stop the emulator too: docker compose down\n"
