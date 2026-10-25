#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENDPOINT="${FLOCI_ENDPOINT:-http://localhost:4566}"
REGION="${AWS_REGION:-us-east-1}"
IMAGE_TAG="${IMAGE_TAG:-v1}"

"$ROOT_DIR/scripts/check-prerequisites.sh"
cd "$ROOT_DIR"
docker compose up -d floci
printf "Waiting for Floci on %s...\n" "$ENDPOINT"

ready=false
for _ in $(seq 1 30); do
  if curl --fail --silent "$ENDPOINT/_floci/health" >/dev/null 2>&1 || curl --fail --silent "$ENDPOINT/health" >/dev/null 2>&1; then
    ready=true
    break
  fi
  sleep 2
done

if [ "$ready" != "true" ]; then
  printf "Floci did not become healthy within 60 seconds. Check: docker compose logs floci\n" >&2
  exit 1
fi

pushd infra >/dev/null
terraform init
terraform apply -auto-approve -var="floci_endpoint=$ENDPOINT" -var="image_tag=$IMAGE_TAG"
REPOSITORY_URL="$(terraform output -raw ecr_repository_url)"
popd >/dev/null

REGISTRY_HOST="${REPOSITORY_URL%%/*}"
aws --endpoint-url "$ENDPOINT" --region "$REGION" ecr get-login-password | docker login --username AWS --password-stdin "$REGISTRY_HOST"
docker build --tag "${REPOSITORY_URL}:${IMAGE_TAG}" app
docker push "${REPOSITORY_URL}:${IMAGE_TAG}"

pushd infra >/dev/null
terraform apply -auto-approve -var="floci_endpoint=$ENDPOINT" -var="image_tag=$IMAGE_TAG" -var="deploy_application=true"
printf "\nDeployment evidence:\n"
aws --endpoint-url "$ENDPOINT" --region "$REGION" ecs describe-services --cluster "$(terraform output -raw ecs_cluster_name)" --services "$(terraform output -raw service_name)"
popd >/dev/null

printf "\nLocal deployment requested successfully. Capture the final ECS output in docs/evidence/.\n"
