#!/bin/bash

set -e

curl -L https://istio.io/downloadIstio | sh -
mv istio-*/bin/istioctl /usr/local/bin/istioctl

pip install -e .
pip install -r requirements-test.txt
pip install git+https://github.com/dask/distributed@main
pip install git+https://github.com/dask/dask@main
# Re-pin k8s-crd-resolver compatible versions after dask[complete]
# upgrades them. openapi-spec-validator<0.5.0 needs jsonschema with
# _legacy_validators (removed in 4.18+), and prance needs to detect
# the openapi-spec-validator backend at the correct version.
pip install "jsonschema==4.17.3" "openapi-spec-validator<0.5.0"
