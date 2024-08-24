#!/bin/bash
set -e

echo "Starting Vault configuration script"

# Fonction pour exécuter des commandes Vault
vault_cmd() {
  kubectl exec -i vault-0 -n $VAULT_NAMESPACE -- vault "$@"
}

# Attendre que Vault soit prêt
until kubectl get pods -n $VAULT_NAMESPACE | grep vault-0 | grep -q Running; do
  echo "Waiting for Vault to be ready..."
  sleep 5
done

# Configurer l'authentification Kubernetes si ce n'est pas déjà fait
if ! vault_cmd auth list | grep -q kubernetes; then
  vault_cmd auth enable kubernetes
fi

# Configurer l'authentification Kubernetes
vault_cmd write auth/kubernetes/config \
token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
issuer="https://kubernetes.default.svc.cluster.local"

echo "Vault configuration completed successfully."