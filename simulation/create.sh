#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Install service mesh
$SCRIPT_DIR/../helm-charts/install-istio.sh

# patch service mesh
kubectl patch service istio-gateway -n istio-system --patch-file "$SCRIPT_DIR/gateway-svc-patch.yaml"

# Enable istio injection
kubectl label namespace default istio-injection=enabled --overwrite

# Install helm chart
helm install bootstrap $SCRIPT_DIR/../helm-charts/bootstrap --wait --create-namespace
