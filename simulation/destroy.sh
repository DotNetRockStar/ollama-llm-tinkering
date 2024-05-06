#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Uninstall the helm chart
helm uninstall bootstrap --wait

# Uninstall the service mesh
$SCRIPT_DIR/../helm-charts/uninstall-istio.sh