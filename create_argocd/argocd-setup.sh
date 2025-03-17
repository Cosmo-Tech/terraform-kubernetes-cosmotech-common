#!/bin/sh
set -e

NAMESPACE=$1
PROJECT=$2
REPOSITORIES=$3

# Check if required parameters are provided
if [ -z "$NAMESPACE" ]; then
    echo "Error: NAMESPACE is required"
    exit 1
fi

# Wait for argo cd server
sleep 30

ARGOCD_SERVER="argocd-server.${NAMESPACE}.svc.cluster.local"
ARGOCD_PASSWORD_FILE="/etc/argocd-initial-admin-secret/password"

if [ ! -f "$ARGOCD_PASSWORD_FILE" ]; then
    echo "Error: ArgoCD password file not found"
    exit 1
fi

ARGOCD_PASSWORD=$(cat $ARGOCD_PASSWORD_FILE)

if [ -z "$ARGOCD_PASSWORD" ]; then
    echo "Error: ArgoCD password is empty"
    exit 1
fi

echo "ArgoCD Server available at: $ARGOCD_SERVER"

# Login to argo cd
if ! argocd login $ARGOCD_SERVER --username admin --password $ARGOCD_PASSWORD --insecure --plaintext; then
    echo "Error: Failed to log in to ArgoCD"
    exit 1
fi

echo "Logged in successfully"

# Add repositories
if [ -n "$REPOSITORIES" ]; then
    echo "$REPOSITORIES" | tr ',' '\n' | while IFS=' ' read -r url private token username; do
        if [ "$private" = "true" ]; then
            if argocd repo add "$url" --server $ARGOCD_SERVER --username "$username" --password "$token"; then
                echo "Added private repository: $url"
            else
                echo "Error: Failed to add private repository $url"
                exit 1
            fi
        else
            if argocd repo add "$url" --server $ARGOCD_SERVER; then
                echo "Added public repository: $url"
            else
                echo "Error: Failed to add public repository $url"
                exit 1
            fi
        fi
    done
else
    echo "No repositories to add."
fi

# Create project
if [ -n "$PROJECT" ]; then
    if ! argocd proj create $PROJECT --server $ARGOCD_SERVER; then
        echo "Error: Failed to create project $PROJECT"
        exit 1
    fi
    echo "Project ${PROJECT} created successfully"
else
    echo "No Project to create"
fi

echo "Setup completed successfully"