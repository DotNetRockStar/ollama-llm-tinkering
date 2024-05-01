#!/bin/bash

helm uninstall istio-ingress -n istio-ingress
helm uninstall istiod -n istio-system
helm uninstall istio-base -n istio-system

echo "Istio is now uninstalled!"