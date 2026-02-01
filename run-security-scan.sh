#!/bin/bash
# Script para rodar security scan manualmente (equivalente ao GitHub Actions)

set -e

echo "=== Building Image for Scan ==="
docker build -t myapp:scan .

echo ""
echo "=== Running Trivy Security Scan ==="
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy:latest image \
  --severity CRITICAL,HIGH,MEDIUM \
  --format table \
  myapp:scan

echo ""
echo "=== Security Scan Complete ==="
