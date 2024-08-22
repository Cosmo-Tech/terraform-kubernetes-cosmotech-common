#!/bin/bash
set -e

NAMESPACE=$1
PROJECT=$2
REPOSITORIES=$3
REPO_USERNAME=$4
REPO_ACCESS_TOKEN=$5

# Check if required parameters are provided
if [ -z "$NAMESPACE" ]; then
    echo "Error: NAMESPACE is required"
    exit 1
fi

# Convert repositories into list
repos=$(echo $REPOSITORIES | tr ',' ' ')

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
    for repo_info in $repos; do
        for i in "${!repo_info[@]}"; do
            if [ ${repo_info[1]} == true ]; then
                argocd repo add ${repo_info[0]} --server $ARGOCD_SERVER --username ${repo_info[3]} --password ${repo_info[2]}
                echo "Added private repository : ${repo_info[0]}"
            elif [ ${repo_info[1]} == false ]; then
                argocd repo add ${repo_info[0]} --server $ARGOCD_SERVER
                echo "Added public repository : ${repo_info[0]}"
            fi
        done
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