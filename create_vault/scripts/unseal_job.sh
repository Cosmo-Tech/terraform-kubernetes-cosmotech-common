#!/bin/bash

NAMESPACE=$1
SECRET_NAME=$2
REPLICAS=$3

# Check if required parameters are provided
if [ -z "$NAMESPACE" ] || [ -z "$SECRET_NAME" ]; then
    echo "Error: All parameters (NAMESPACE, SECRET_NAME) are required"
    exit 1
fi

# Function to check if all Vault pods are running
check_vault_pods() {
    for i in $(seq 0 $(($REPLICAS - 1))); do
        status=$(kubectl get pod vault-$i -n $NAMESPACE -o jsonpath='{.status.phase}')
        if [ "$status" != "Running" ]; then
            return 1
        fi
    done
    return 0
}

# Wait for Vault pods to be running
echo "Waiting for all Vault pods to be in Running state..."
while ! check_vault_pods; do
    echo "Waiting for Vault pods..."
    sleep 10
done
echo "All Vault pods are running."

unseal_keys=$(kubectl get secret -n vault vault-token-secret -o jsonpath='{.data.UNSEAL_KEYS}' | base64 -d)

echo $unseal_keys | tr ',' '\n' | while IFS=' ' read -r KEY0 KEY1 KEY2 KEY3 KEY4; do
  # Unseal Vault-0
  kubectl exec vault-0 --namespace $NAMESPACE -- vault operator unseal $KEY0
done

# Unseal replicas
for i in $(seq 1 $(($REPLICAS - 1))); do
  keys=$(echo $unseal_keys | tr ',' ' ')
  for key in $keys; do
    kubectl exec vault-$i --namespace $NAMESPACE -- vault operator unseal $key
  done
  echo "replica $i unsealed"
done