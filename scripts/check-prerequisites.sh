#!/usr/bin/env bash
set -euo pipefail

missing=0
for command in docker terraform; do
  if command -v "$command" >/dev/null 2>&1; then
    printf "OK: %s -> %s\n" "$command" "$(command -v "$command")"
  else
    printf "MISSING: %s\n" "$command" >&2
    missing=1
  fi
done

if ! docker info >/dev/null 2>&1; then
  printf "WARNING: Docker command is present but its daemon is unavailable. Start Docker Desktop first.\n" >&2
  missing=1
fi

if docker compose version >/dev/null 2>&1; then
  printf "OK: docker compose available\n"
else
  printf "MISSING: Docker Compose v2\n" >&2
  missing=1
fi

printf "INFO: AWS CLI is intentionally not required on the host. The Floci compat container provides it locally.\n"
exit "$missing"
