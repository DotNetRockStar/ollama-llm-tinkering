#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Install service mesh
$SCRIPT_DIR/../helm-charts/install-istio.sh

# patch service mesh
# kubectl patch service istio-ingress --patch-file istio-svc-patch.yaml -n istio-ingress

# Enable istio injection
kubectl label namespace default istio-injection=enabled --overwrite

# Install helm chart
helm install bootstrap $SCRIPT_DIR/../helm-charts/bootstrap --set global.networking.istio.enabled=false --wait --create-namespace


# kubectl port-forward hello-app-864584964-fn8l6 1111:80 &
# PID1=$(echo $!)
# kubectl port-forward hello-app-864584964-fn8l6 1112:80 &
# PID2=$(echo $!)
# kubectl port-forward hello-app-864584964-fn8l6 1113:80 &
# PID3=$(echo $!)
# kubectl port-forward hello-app-864584964-fn8l6 1114:80 &
# PID4=$(echo $!)

