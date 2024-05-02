#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Install service mesh
$SCRIPT_DIR/../helm-charts/install-istio.sh

# patch service mesh
kubectl patch service istio-ingress --patch-file istio-svc-patch.yaml -n istio-system

# Enable istio injection
kubectl label namespace default istio-injection=enabled --overwrite

# Install helm chart
helm install bootstrap $SCRIPT_DIR/../helm-charts/bootstrap --wait --create-namespace

# Install prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus --wait
kubectl patch service prometheus-server --patch-file nodeport-patch.yaml -n default

# Install kiali: https://github.com/kiali/helm-charts/tree/master/kiali-server
helm install \
  --namespace istio-system \
  --set auth.strategy="anonymous" \
  --set external_services.prometheus.url=http://prometheus-kube-state-metrics.default.svc.cluster.local/ \
  --repo https://kiali.org/helm-charts \
  kiali-server \
  kiali-server \
  --wait
kubectl patch service kiali --patch-file nodeport-patch.yaml -n istio-system

# kubectl port-forward hello-app-864584964-fn8l6 1111:80 &
# PID1=$(echo $!)
# kubectl port-forward hello-app-864584964-fn8l6 1112:80 &
# PID2=$(echo $!)
# kubectl port-forward hello-app-864584964-fn8l6 1113:80 &
# PID3=$(echo $!)
# kubectl port-forward hello-app-864584964-fn8l6 1114:80 &
# PID4=$(echo $!)

# Could not fetch metrics: error in metric request_count: Post "http://prometheus.istio-system:9090/api/v1/query_range": dial tcp: lookup prometheus.istio-system on 10.43.0.10:53: no such host


# Could not fetch health: Error while fetching app health: Post "http://prometheus.istio-system:9090/api/v1/query": dial tcp: lookup prometheus.istio-system on 10.43.0.10:53: no such host
