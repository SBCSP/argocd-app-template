# ArgoCD App Template

A bootstrap script to quickly scaffold the standard folder structure for ArgoCD-managed Kubernetes applications.

## Quick Start

Run this one-liner with your environment and cluster names:
```bash
curl -fsSL https://raw.githubusercontent.com/SBCSP/argocd-app-template/main/bootstrap.sh | bash -s <environment> <cluster>
```

**Example:**
```bash
curl -fsSL https://raw.githubusercontent.com/SBCSP/argocd-app-template/main/bootstrap.sh | bash -s prod us-east-1
```

Or for a safer two-step approach with interactive prompts:
```bash
curl -fsSL https://raw.githubusercontent.com/SBCSP/argocd-app-template/main/bootstrap.sh -o bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

## Arguments

| Argument | Position | Description | Default |
|----------|----------|-------------|---------|
| `environment` | 1 | Environment name (e.g., `prod`, `dev`, `stage`) | `dev` |
| `cluster` | 2 | Kubernetes cluster name (e.g., `us-east-1`, `prod-cluster`) | `cluster-01` |

**Piped execution** (`curl | bash -s`): Arguments are required or defaults are used (no interactive prompts).

**Direct execution** (`./bootstrap.sh`): If arguments are omitted, the script will prompt interactively.

## What It Creates

```
├── chart/
│   └── Chart.yaml           # Root Helm chart metadata
├── common/
│   └── values.yaml          # Shared values across environments
├── env/
│   └── {environment}/
│       └── {cluster}/
│           ├── Chart.yaml       # Environment-specific chart
│           ├── config.yaml      # Cluster configuration
│           ├── templates/       # Kubernetes manifests
│           │   └── example.yaml
│           └── values.yaml      # Environment-specific values
├── manual/
│   └── secrets.yaml         # Manual secrets (gitignored)
├── .gitignore
└── README.md
```

## Usage

After running the bootstrap script:

1. **Initialize your git repository:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: ArgoCD app structure"
   ```

2. **Push to your Git provider:**
   ```bash
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

3. **Add your Kubernetes manifests** to `env/{environment}/{cluster}/templates/`

4. **Configure ArgoCD** to watch your repository

ArgoCD's SCM Provider will automatically discover and deploy applications based on the `env/` folder structure.

## Development

Test your manifests locally before committing:
```bash
# Render templates
helm template my-app env/{environment}/{cluster}/ -f common/values.yaml

# Install to cluster
helm upgrade --install my-app env/{environment}/{cluster}/ \
  -f common/values.yaml \
  --namespace my-app \
  --create-namespace
```

## Features

- ✅ Non-interactive piped execution with arguments
- ✅ Interactive prompts when run directly
- ✅ Pre-configured `.gitignore` for secrets
- ✅ Helm chart structure ready for ArgoCD
- ✅ Common values inheritance pattern
- ✅ Example templates to get started quickly

## Requirements

- `bash` (Linux/macOS/WSL)
- `git` (for version control after scaffolding)

## Contributing

Issues and pull requests welcome! This template is maintained by [SandboxCSP](https://github.com/SBCSP).

## License

MIT License - feel free to use this for your projects!