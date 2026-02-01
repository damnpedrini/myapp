#!/bin/bash
# Script para rodar build manualmente (equivalente ao GitHub Actions)

set -e

echo "=== Building Docker Image ==="
docker build -t damnpedrini/myapp:latest .

echo ""
echo "=== Pushing to Docker Hub ==="
docker push damnpedrini/myapp:latest

echo ""
echo "=== Build Complete ==="
echo "Image: damnpedrini/myapp:latest"
