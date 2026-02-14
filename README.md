# ArgoCD App Template

A bootstrap script to quickly scaffold the standard folder structure for ArgoCD-managed Kubernetes applications.

## Quick Start

Run this one-liner to scaffold your project structure:
```bash
curl -fsSL https://raw.githubusercontent.com/SBCSP/argocd-app-template/main/bootstrap.sh | bash
```

Or for a safer two-step approach (recommended):
```bash
curl -fsSL https://raw.githubusercontent.com/SBCSP/argocd-app-template/main/bootstrap.sh -o bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

## What It Does

The script will interactively prompt you for:
- **Environment name** (e.g., `prod`, `dev`, `stage`)
- **Kubernetes cluster name** (e.g., `us-east-1`, `prod-cluster`)

Then it creates this structure:
```
├── chart/
│   └── Chart.yaml           # Root Helm chart metadata
├── common/
│   └── values.yaml          # Shared values across environments
├── env/
│   └── {environment_name}/
│       └── {cluster_name}/
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

- ✅ Interactive environment and cluster configuration
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