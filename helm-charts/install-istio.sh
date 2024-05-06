#!/bin/bash

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

if [[ $(helm ls -n istio-system | grep istio-base) == "" ]]; then
    helm install istio-base istio/base -n istio-system --set defaultRevision=default --wait --create-namespace
else
    echo "istio/base helm chart already installed."
fi

if [[ $(helm ls -n istio-system | grep istiod) == "" ]]; then
    helm install istiod istio/istiod -n istio-system --wait
else
    echo "istio/istiod helm chart already installed."
fi  

if [[ $(helm ls -n istio-system | grep istio-gateway) == "" ]]; then
    helm install istio-gateway istio/gateway --set service.type=NodePort -n istio-system --wait --create-namespace
else
    echo "istio/gateway helm chart already installed."
fi

if [[ $(kubectl describe ns default | grep istio-injection=enabled) == "" ]]; then
    kubectl label namespace default istio-injection=enabled --overwrite
else
    echo "default namespace already has istio-injection=true label applied."
fi

echo "Istio is now installed!"