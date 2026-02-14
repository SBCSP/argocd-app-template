#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  Kubernetes Project Structure Setup${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Check for command-line arguments
if [ $# -eq 2 ]; then
    ENV_NAME="$1"
    CLUSTER_NAME="$2"
    echo -e "${GREEN}Using arguments: Environment=$ENV_NAME, Cluster=$CLUSTER_NAME${NC}"
else
    # Prompt for environment name
    read -p "Enter the environment name (e.g., prod, dev, stage): " ENV_NAME
    if [ -z "$ENV_NAME" ]; then
        echo -e "${YELLOW}No environment name provided. Using 'dev' as default.${NC}"
        ENV_NAME="dev"
    fi

    # Prompt for cluster name
    read -p "Enter the Kubernetes cluster name: " CLUSTER_NAME
    if [ -z "$CLUSTER_NAME" ]; then
        echo -e "${YELLOW}No cluster name provided. Using 'cluster-01' as default.${NC}"
        CLUSTER_NAME="cluster-01"
    fi
fi

echo ""
echo -e "${GREEN}Creating project structure...${NC}"
echo "Environment: $ENV_NAME"
echo "Cluster: $CLUSTER_NAME"
echo ""

# Create directory structure
mkdir -p chart
mkdir -p common
mkdir -p env/$ENV_NAME/$CLUSTER_NAME/templates
mkdir -p manual

# Create chart/Chart.yaml
cat > chart/Chart.yaml << EOF
apiVersion: v2
name: $CLUSTER_NAME
description: Helm chart for $ENV_NAME environment
type: application
version: 0.1.0
appVersion: "1.0"
EOF

# Create common/values.yaml
cat > common/values.yaml << 'EOF'
# Common values shared across all environments
# Override these in environment-specific values.yaml files
EOF

# Create env/{environment_name}/{cluster_name}/Chart.yaml
cat > env/$ENV_NAME/$CLUSTER_NAME/Chart.yaml << EOF
apiVersion: v2
name: $CLUSTER_NAME
description: Helm chart for $ENV_NAME environment
type: application
version: 0.1.0
appVersion: "1.0"
EOF

# Create env/{environment_name}/{cluster_name}/config.yaml
cat > env/$ENV_NAME/$CLUSTER_NAME/config.yaml << EOF
# Configuration for $CLUSTER_NAME in $ENV_NAME environment
environment: $ENV_NAME
cluster: $CLUSTER_NAME
EOF

# Create env/{environment_name}/{cluster_name}/values.yaml
cat > env/$ENV_NAME/$CLUSTER_NAME/values.yaml << EOF
# Environment-specific values for $ENV_NAME/$CLUSTER_NAME
# These override values from common/values.yaml
EOF

# Create env/{environment_name}/{cluster_name}/templates/example.yaml
cat > env/$ENV_NAME/$CLUSTER_NAME/templates/example.yaml << 'EOF'
# Example Kubernetes manifest template
# Add your resource definitions here
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-config
data:
  example.key: "example-value"
EOF

# Create manual/secrets.yaml
cat > manual/secrets.yaml << 'EOF'
# Manual secrets configuration
# DO NOT commit actual secrets to version control
# This file should be added to .gitignore
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Ignore secrets
manual/secrets.yaml

# Ignore temporary files
*.tmp
*.bak
*~

# Ignore IDE files
.vscode/
.idea/
*.swp
EOF

# Create README.md
cat > README.md << EOF
# Kubernetes Configuration - $ENV_NAME/$CLUSTER_NAME

## Structure

\`\`\`
├── chart/
│   └── Chart.yaml       # Root Helm chart metadata
├── common/              # Shared values across environments
├── env/
│   └── $ENV_NAME/
│       └── $CLUSTER_NAME/
│           ├── Chart.yaml       # Helm chart metadata
│           ├── config.yaml      # Environment configuration
│           ├── templates/       # Kubernetes manifests
│           └── values.yaml      # Environment-specific values
└── manual/
    └── secrets.yaml     # Manual secrets (gitignored)
\`\`\`

## Usage

1. Update \`common/values.yaml\` with shared configuration
2. Update \`env/$ENV_NAME/$CLUSTER_NAME/values.yaml\` with environment-specific overrides
3. Add Kubernetes manifests to \`env/$ENV_NAME/$CLUSTER_NAME/templates/\`
4. Configure secrets in \`manual/secrets.yaml\` (never commit this!)

## Getting Started

\`\`\`bash
# Install/update the chart
helm upgrade --install my-release env/$ENV_NAME/$CLUSTER_NAME/

# With custom values
helm upgrade --install my-release env/$ENV_NAME/$CLUSTER_NAME/ -f common/values.yaml
\`\`\`
EOF

echo -e "${GREEN}✓ Project structure created successfully!${NC}"
echo ""
echo "Structure created:"
tree -L 4 2>/dev/null || find . -type f -o -type d | grep -v "^\.\/\." | sort

echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Initialize git repository: git init"
echo "2. Add secrets to manual/secrets.yaml (already gitignored)"
echo "3. Customize values in common/values.yaml and env/$ENV_NAME/$CLUSTER_NAME/values.yaml"
echo "4. Add your Kubernetes manifests to env/$ENV_NAME/$CLUSTER_NAME/templates/"
echo ""
echo -e "${GREEN}Happy deploying! 🚀${NC}"