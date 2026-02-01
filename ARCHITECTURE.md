# Architecture Documentation

## Overview

MyApp is designed following cloud-native principles with focus on:
- **Scalability**: Horizontal pod autoscaling ready
- **Reliability**: Health checks and self-healing
- **Observability**: Structured logging and metrics
- **Security**: Image scanning and minimal attack surface

## Technology Decisions

### Why Nginx Alpine?
- **Size**: ~25MB vs ~150MB for standard nginx
- **Security**: Minimal attack surface, fewer CVEs
- **Performance**: Fast startup time, low memory footprint

### Why K3s?
- **Lightweight**: Perfect for single-node or edge deployments
- **Production-ready**: Used by Rancher, CNCF certified
- **Feature-complete**: Includes Traefik, local storage, etc.

### Why Helm?
- **Templating**: Reusable configurations across environments
- **Versioning**: Rollback capabilities
- **Package management**: Easy distribution and installation

## Infrastructure Components

### Ingress (Traefik)
```yaml
Host: srv688480.hstgr.cloud
TLS: Not configured (TODO)
```

### Service (NodePort)
```yaml
Type: NodePort
Port: 80
NodePort: 30658
```

### Deployment
```yaml
Replicas: 1 (TODO: Add HPA)
Strategy: RollingUpdate
```

## Deployment Flow
```
1. Developer commits code
   ↓
2. GitHub Actions triggered
   ↓
3. Docker image built & scanned
   ↓
4. Pushed to Docker Hub
   ↓
5. Helm upgrade (manual/automated)
   ↓
6. Kubernetes rolling update
   ↓
7. Zero-downtime deployment
```

## Future Improvements

- [ ] Add liveness/readiness probes
- [ ] Implement HPA (Horizontal Pod Autoscaler)
- [ ] Add resource limits/requests
- [ ] Configure TLS/HTTPS
- [ ] Add Prometheus metrics
- [ ] Implement GitOps with ArgoCD
- [ ] Multi-environment setup (dev/staging/prod)
- [ ] Add integration tests
