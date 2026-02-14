# Kubernetes Configuration - dev/test

## Structure

```
├── chart/
│   └── Chart.yaml       # Root Helm chart metadata
├── common/              # Shared values across environments
├── env/
│   └── dev/
│       └── test/
│           ├── Chart.yaml       # Helm chart metadata
│           ├── config.yaml      # Environment configuration
│           ├── templates/       # Kubernetes manifests
│           └── values.yaml      # Environment-specific values
└── manual/
    └── secrets.yaml     # Manual secrets (gitignored)
```

## Usage

1. Update `common/values.yaml` with shared configuration
2. Update `env/dev/test/values.yaml` with environment-specific overrides
3. Add Kubernetes manifests to `env/dev/test/templates/`
4. Configure secrets in `manual/secrets.yaml` (never commit this!)

## Getting Started

```bash
# Install/update the chart
helm upgrade --install my-release env/dev/test/

# With custom values
helm upgrade --install my-release env/dev/test/ -f common/values.yaml
```
