#!/bin/bash

helm uninstall istio-gateway -n istio-system
helm uninstall istiod -n istio-system
helm uninstall istio-base -n istio-system

echo "Istio is now uninstalled!"