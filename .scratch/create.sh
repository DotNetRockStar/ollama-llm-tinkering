# TODO: Later
# # Install prometheus
# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm repo update
# helm install prometheus prometheus-community/prometheus --wait
# kubectl patch service prometheus-server --patch-file nodeport-patch.yaml -n default

# # Install kiali: https://github.com/kiali/helm-charts/tree/master/kiali-server
# helm install \
#   --namespace istio-system \
#   --set auth.strategy="anonymous" \
#   --set external_services.prometheus.url=http://prometheus-kube-state-metrics.default.svc.cluster.local/ \
#   --repo https://kiali.org/helm-charts \
#   kiali-server \
#   kiali-server \
#   --wait
# kubectl patch service kiali --patch-file nodeport-patch.yaml -n istio-system

# kubectl port-forward hello-app-864584964-fn8l6 1111:80 &
# PID1=$(echo $!)