# MyApp - Cloud-Native Web Application

[![Docker Build](https://img.shields.io/badge/docker-automated-blue)](https://hub.docker.com/r/damnpedrini/myapp)
[![Kubernetes](https://img.shields.io/badge/kubernetes-ready-326CE5)](https://kubernetes.io/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

Production-grade containerized application demonstrating advanced DevOps practices and cloud-native architecture on Kubernetes.

## Technical Overview

This project implements a complete containerization and orchestration workflow including:
- Docker multi-stage builds with Alpine Linux base
- Kubernetes deployment with Helm package management
- CI/CD automation with GitHub Actions
- Infrastructure as Code principles
- Production-ready configurations with health checks and resource management

## Architecture
```
                    ┌─────────────────┐
                    │   Ingress       │
                    │   (Traefik)     │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │   Service       │
                    │   (NodePort)    │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │   Deployment    │
                    │   (ReplicaSet)  │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │      Pod        │
                    │   nginx:alpine  │
                    └─────────────────┘
```

## Technology Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| Container Runtime | Docker | Latest |
| Orchestration | Kubernetes (K3s) | v1.28+ |
| Package Manager | Helm | 3.x |
| Ingress Controller | Traefik | 2.x |
| Web Server | Nginx Alpine | Latest |
| Container Registry | Docker Hub | - |
| CI/CD | GitHub Actions | - |

## Prerequisites

- Docker Engine 20.10+
- Kubernetes cluster (K3s recommended for lightweight deployments)
- Helm 3.0+
- kubectl configured with cluster access

## Local Development

Build and run the container locally:
```bash
git clone https://github.com/damnpedrini/myapp.git
cd myapp

docker build -t myapp:local .
docker run -d -p 8080:80 myapp:local

# Verify
curl http://localhost:8080
```

## Kubernetes Deployment

### Install
```bash
# Using Helm
helm install myapp .

# Verify resources
kubectl get deployment,pod,svc,ingress
```

### Configuration

Customize deployment via `values.yaml`:
```yaml
image:
  repository: damnpedrini/myapp
  tag: latest
  pullPolicy: Always

replicaCount: 1

resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 50m
    memory: 64Mi
```

### Upgrade
```bash
# Update configuration
helm upgrade myapp . -f values.yaml

# Or override specific values
helm upgrade myapp . --set replicaCount=3
```

### Rollback
```bash
helm rollback myapp
```

### Uninstall
```bash
helm uninstall myapp
```

## CI/CD Pipeline

Automated workflows in `.github/workflows/`:

### docker-build.yml
- Triggers on push to main/develop branches and tags
- Multi-platform Docker builds
- Automated push to Docker Hub registry
- Build caching for improved performance

### security-scan.yml
- Trivy vulnerability scanning
- SARIF report generation
- Integration with GitHub Security tab
- Scheduled weekly scans

### Required Secrets

Configure in GitHub repository settings:
- `DOCKER_USERNAME`: Docker Hub username
- `DOCKER_TOKEN`: Docker Hub access token

## Project Structure
```
myapp/
├── .github/
│   └── workflows/
│       ├── docker-build.yml
│       └── security-scan.yml
├── app/
│   └── index.html
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── _helpers.tpl
├── Chart.yaml
├── values.yaml
├── Dockerfile
├── ARCHITECTURE.md
└── README.md
```

## Helm Chart Details

### Templates

- **deployment.yaml**: Manages pod replicas with rolling update strategy
- **service.yaml**: Exposes pods via NodePort service
- **ingress.yaml**: Configures external access routing
- **_helpers.tpl**: Reusable template functions

### Values Reference

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `image.repository` | string | `damnpedrini/myapp` | Container image repository |
| `image.tag` | string | `latest` | Image tag |
| `image.pullPolicy` | string | `Always` | Image pull policy |
| `replicaCount` | int | `1` | Number of pod replicas |
| `service.type` | string | `NodePort` | Service type |
| `service.port` | int | `80` | Service port |
| `resources.limits.cpu` | string | `100m` | CPU limit |
| `resources.limits.memory` | string | `128Mi` | Memory limit |
| `resources.requests.cpu` | string | `50m` | CPU request |
| `resources.requests.memory` | string | `64Mi` | Memory request |

## Operational Commands

### Debugging
```bash
# Pod logs
kubectl logs -f deployment/myapp-myapp

# Pod shell access
kubectl exec -it deployment/myapp-myapp -- /bin/sh

# Describe resources
kubectl describe deployment myapp-myapp
kubectl describe pod -l app=myapp
```

### Monitoring
```bash
# Resource usage
kubectl top pods

# Watch pod status
kubectl get pods -w

# Event monitoring
kubectl get events --sort-by='.lastTimestamp'
```

## Development Workflow

1. Clone repository and create feature branch
2. Modify application code in `app/`
3. Build and test locally with Docker
4. Commit changes and push to GitHub
5. CI/CD pipeline automatically builds and scans
6. Tag release for production deployment
7. Helm upgrade in Kubernetes cluster

## Production Considerations

### Implemented
- Resource limits and requests
- Liveness and readiness probes
- Rolling update deployment strategy
- Security scanning in CI/CD
- Minimal Alpine-based images

### Recommended Additions
- Horizontal Pod Autoscaler (HPA)
- Pod Disruption Budget (PDB)
- Network policies
- TLS/HTTPS configuration
- Centralized logging (ELK/Loki)
- Metrics collection (Prometheus)
- GitOps deployment (ArgoCD/Flux)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss proposed changes.

## License

MIT License - See LICENSE file for details

## Author

Pedro Pedrini
- GitHub: [@damnpedrini](https://github.com/damnpedrini)
