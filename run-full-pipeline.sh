#!/bin/bash
# Script para rodar pipeline completo manualmente

set -e

echo "======================================"
echo "    MyApp - Full CI/CD Pipeline"
echo "======================================"
echo ""

# Build
echo "[1/3] Building Docker Image..."
docker build -t damnpedrini/myapp:latest .
echo "✓ Build complete"
echo ""

# Security Scan
echo "[2/3] Running Security Scan..."
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy:latest image \
  --severity CRITICAL,HIGH \
  --exit-code 0 \
  damnpedrini/myapp:latest
echo "✓ Security scan complete"
echo ""

# Push
echo "[3/3] Pushing to Docker Hub..."
docker push damnpedrini/myapp:latest
echo "✓ Push complete"
echo ""

echo "======================================"
echo "    Pipeline Complete!"
echo "======================================"
echo "Next steps:"
echo "  helm upgrade myapp ."
echo "  kubectl rollout status deployment/myapp-myapp"
